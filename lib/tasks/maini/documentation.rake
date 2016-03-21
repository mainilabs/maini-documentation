namespace :maini do
  namespace :doc do

    desc "Atualiza o banco de documentação"
    task :update => :environment do

      resource_parser_path  = File.join(File.dirname(__FILE__),'..','..','..','vendor', 'javascripts','api_resource.js')
      action_parser_path    = File.join(File.dirname(__FILE__),'..','..','..','vendor', 'javascripts','api_action.js')
      template_path         = File.join(File.dirname(__FILE__),'..','..','..','vendor', 'template')

      # Create json for API
      generated = system "apidoc -i docs/ -o tmp/maini/ --parse-parsers apiresource=#{resource_parser_path} --parse-parsers apiaction=#{action_parser_path} -t #{template_path} --silent"

      if generated
        Maini::Documentation::Updater.api_json_path = "tmp/maini/api_data.json"

        Maini::Documentation::Updater.process

        # Remove unused files
        # system 'rm -R tmp/maini'

      end

    end


  end
end