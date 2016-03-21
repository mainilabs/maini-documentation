module Maini
  module Documentation
    class EndpointsController < Maini::Documentation::ApplicationController

      def index

        @api_items = Apidoc.where(resource: params[:resource])

      end

      def action

        @api_item = Apidoc.find_by(resource: params[:resource], action: params[:act])

      end

    end
  end
end