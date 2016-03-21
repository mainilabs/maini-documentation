require 'json'

module Maini
  module Documentation
    module Updater

      mattr_accessor :api_json_path do
        "tmp/api_data.json"
      end

      class << self

        def process()

          json_file   = File.open(api_json_path)
          json_string = json_file.read
          json_object = JSON.parse(json_string)

          Maini::Documentation::Apidoc.destroy_all
          ActiveRecord::Base.connection.execute("TRUNCATE maini_documentation_apidocs RESTART IDENTITY")

          json_object.each do |api|

            attrs = {
              version: api['version'],
              type_api: api['type'],
              url: api['url'],
              title: api['title'],
              name: api['name'],
              group: api['group'],
              resource: api['resource'],
              action: api['action'],
              examples: api['examples'],
              success: api['success'],
              error: api['error'],
              filename: api['filename']
            }

            Maini::Documentation::Apidoc.create(attrs)
          end

        end

      end


    end
  end
end