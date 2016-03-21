require 'rails/generators'
require 'rails/generators/generated_attribute'
require 'htmlentities'

module Maini
  module Generators
    class DocGenerator < ::Rails::Generators::Base
      include Maini::Documentation::Helper

      source_root File.expand_path('../templates', __FILE__)
      argument :controller_path,    :type => :string
      argument :api_name,           :type => :string

      class_option :excluded_columns, :type => :array, :required => false

      def initialize(args, *options)
        super(args, *options)
        initialize_views_variables
      end

      def copy_views
        generate_views
      end

      protected

      def initialize_views_variables
        @base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(controller_path)
        @controller_routing_path = @controller_file_path.gsub(/\//, '_')
        @model_name = @controller_class_nesting + "::#{@base_name.singularize.camelize}" unless @model_name
        @model_name = @model_name.camelize
      end

      def controller_routing_path
        ActiveModel::Naming.route_key(@model_name.constantize)
      end

      def resource_route_path
        Rails.application.routes.url_helpers.send("#{@controller_routing_path}_path".to_sym)
      end

      def singular_controller_routing_path
        ActiveModel::Naming.singular_route_key(@model_name.constantize)
      end

      def model_name
        @model_name
      end

      def plural_model_name
        @model_name.pluralize
      end

      def plural_class_name
        resource_name.classify.pluralize
      end

      def singular_class_name
        resource_name.classify
      end

      def resource_name
        @model_name.demodulize.underscore
      end

      def plural_resource_name
        resource_name.pluralize
      end

      def api_group
        api_group_number = 1
        "#{api_group_number.to_s.rjust(2,'0')} - #{api_name}"
      end

      def api_group_folder
        plural_resource_name.parameterize
      end

      def api_group_encoded
        HTMLEntities.new.encode(api_name, :named)
      end

      def columns
        retrieve_columns.reject {|c| excluded?(c.name) }.map do |c|
          new_attribute(c.name, c.type.to_sym)
        end
      end

      def columns_for_create_and_update
        retrieve_columns.reject {|c| excluded_for_create_and_update?(c.name) }.map do |c|
          new_attribute(c.name, c.type.to_sym)
        end
      end

      def excluded_columns_names
        # %w[_id _type id created_at updated_at]
        []
      end

      def excluded_columns_names_for_create_and_update
        %w[id created_at updated_at]
      end

      def excluded_columns_pattern
        [
            /.*_checksum/,
            /.*_count/,
        ]
      end

      def excluded_columns
        options['excluded_columns']||[]
      end

      def excluded?(name)
        excluded_columns_names.include?(name) ||
            excluded_columns_pattern.any? {|p| name =~ p } ||
            excluded_columns.include?(name)
      end

      def excluded_for_create_and_update?(name)
        excluded_columns_names_for_create_and_update.include?(name)
      end

      def retrieve_columns
        if defined?(ActiveRecord) == "constant" && ActiveRecord.class == Module
          rescue_block ActiveRecord::StatementInvalid do
            @model_name.constantize.columns
          end
        else
          rescue_block do
            @model_name.constantize.fields.map {|c| c[1] }
          end
        end
      end


      def new_attribute(name, type)
        ::Rails::Generators::GeneratedAttribute.new(name, type)
      end

      def rescue_block(exception=Exception)
        yield if block_given?
      rescue exception => e
        say e.message, :red
        exit
      end

      def extract_modules(name)
        modules = name.include?('/') ? name.split('/') : name.split('::')
        name    = modules.pop
        path    = modules.map { |m| m.underscore }
        file_path = (path + [name.underscore]).join('/')
        nesting = modules.map { |m| m.camelize }.join('::')
        [name, path, file_path, nesting, modules.size]
      end

      def generate_views
        options.engine == generate_doc_files(selected_views)
      end

      def selected_views
        {
            'index.rb'             => File.join('docs', api_group_folder, "index.rb"),
            'show.rb'              => File.join('docs', api_group_folder, "show.rb"),
            'create.rb'            => File.join('docs', api_group_folder, "create.rb"),
            'update.rb'            => File.join('docs', api_group_folder, "update.rb"),
            'destroy.rb'           => File.join('docs', api_group_folder, "destroy.rb"),
        }
      end

      def doc_config
        Maini::Documentation::Configuration
      end

      def generate_doc_files(views)
        views.each do |template_name, output_path|
          template template_name, output_path
        end
      end

      def ext
        ::Rails.application.config.generators.options[:rails][:template_engine] || :erb
      end

      def form_builder
        defined?(::SimpleForm) ? 'simple_form/' : ''
      end
    end
  end
end