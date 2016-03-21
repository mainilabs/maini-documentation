require 'rails'
require "maini/documentation/version"
require "maini/documentation/railtie"
require "maini/documentation/engine"
require 'bootstrap-sass'

module Maini
  module Documentation
    autoload :Helper, 'maini/documentation/helper'
    autoload :Configuration, 'maini/documentation/configuration'
    autoload :Updater, 'maini/documentation/updater'



    class << self

      def setup(&block)
        Maini::Documentation::Configuration.setup(&block)
      end

    end


  end
end
