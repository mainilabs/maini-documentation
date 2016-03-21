=begin
@apiVersion <%= doc_config.api_version %>
@api {get} <%= resource_route_path %>  <%= doc_config.action_titles[:index] %>
@apiId search
@apiName get<%= plural_class_name %>
@apiGroup <%= api_group %>

@apiExample Autenticacao por Header
  HTTP_ACCEPT: application/json
  X-Auth-Token: "x7kqavrqwnbg5itmr5BA"
  X-Auth-Email: "admin@admin.com.br"
  X-Auth-Register: "HauheUheauHeIAheila"

<%= index_default_params %>

@apiSuccessExample Success-Response-Example:
  HTTP/1.1 200 Ok
    {
      "total_pages": 1,
      "count": 1,
      "from": 1,
      "to": 1,
      "current_page": 1,
      "results" : [
        {
<%- columns.each do |column| -%>
          "<%= column.name %>": "<%= column.default %>",
<%- end -%>
        }
      ]
    }


@apiErrorExample Unauthorized Response:
  HTTP/1.1 401 Unauthorized
  {
    "error": "You need to sign in or sign up before continuing."
  }

=end