module Maini
  module Documentation
    module Helper


      def index_default_params
        <<TEXT
@apiParam {String} [q] Realiza uma busca por caracteres
@apiParam {Integer} [page] Numero da pagina
@apiParam {String} [fields] Campos que gostaria de trazer na lista, separados por virgula, por exemplo: id,nome
TEXT
      end




      def example(column)
      end

    end
  end
end