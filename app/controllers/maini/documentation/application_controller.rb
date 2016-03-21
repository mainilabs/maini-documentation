module Maini
  module Documentation
    class ApplicationController < ActionController::Base
      maini_auth_public if defined?(:maini_auth_public)
      before_action :load_sidebar



      protected
      def load_sidebar
        @version = Maini::Documentation::VERSION
        @all_items = Apidoc.all
        @grouped_items = @all_items.group_by { |item| item.resource }
        @resources = @grouped_items.keys
      end
    end
  end
end