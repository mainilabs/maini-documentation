module Maini
  module Documentation
    module Configuration

      mattr_accessor :actions do
        [:index, :show, :create, :update, :destroy]
      end

      mattr_accessor :api_version do
        "0.0.1"
      end

      mattr_accessor :action_titles do 
        {
          index: 'Buscar',
          show: 'Carregar',
          create: 'Cadastrar',
          update: 'Alterar',
          destroy: 'Remover'
        }
      end

      mattr_accessor :docs_enable do
        []
      end

      class << self

        def setup(&block)
          yield self if block_given?
          self
        end

      end

    end
  end
end