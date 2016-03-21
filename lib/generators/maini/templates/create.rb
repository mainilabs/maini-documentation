=begin
@apiVersion <%= doc_config.api_version %>
@api {post} <%= resource_route_path %> <%= doc_config.action_titles[:create] %>
@apiId create
@apiName post<%= plural_class_name %>
@apiGroup <%= api_group %>

@apiExample Autenticacao por Header
  HTTP_ACCEPT: application/json
  X-Auth-Token: "x7kqavrqwnbg5itmr5BA"
  X-Auth-Email: "admin@admin.com.br"
  X-Auth-Register: "HauheUheauHeIAheila"

@apiParam {Object} <%= resource_name %>
<%- columns_for_create_and_update.each do |column| -%>
@apiParam {<%= column.type.capitalize %>} <%= resource_name %>.<%= column.name %> <%= column.human_name %>
<%- end -%>

@apiExample Exemplo de Json para request
  {
<%- columns_for_create_and_update.each do |column| -%>
    "<%= column.name %>": "<%= column.default %>",
<%- end -%>
  }

@apiSuccessExample Success-Response-Example:
  HTTP/1.1 200 OK
  {
<%- columns.each do |column| -%>
    "<%= column.name %>": "<%= column.default %>",
<%- end -%>
  }
=end