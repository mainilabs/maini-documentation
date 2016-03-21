Maini::Documentation::Engine.routes.draw do

  root to: 'home#index'

  get 'endpoints/:resource' 		=> 'endpoints#index', 	as: :endpoint
  get 'endpoints/:resource/(:act)' 	=> 'endpoints#action', 	as: :endpoint_action

end
