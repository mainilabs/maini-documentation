=begin
@apiVersion <%= doc_config.api_version %>
@api {delete} <%= resource_route_path %>/:id  <%= doc_config.action_titles[:destroy] %>
@apiId destroy
@apiName destroy<%= singular_class_name %>
@apiGroup <%= api_group %>

@apiExample Autenticacao por Header
  HTTP_ACCEPT: application/json
  X-Auth-Token: "x7kqavrqwnbg5itmr5BA"
  X-Auth-Email: "admin@admin.com.br"
  X-Auth-Register: "HauheUheauHeIAheila"

@apiSuccessExample Success-Response-Example:
  HTTP/1.1 204 No Content

@apiErrorExample Unauthorized Response:
  HTTP/1.1 401 Unauthorized
  {
    "error": "You need to sign in or sign up before continuing."
  }

=end