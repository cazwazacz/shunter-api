Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/people',             to: 'people#index'
  get '/people/:person_id',  to: 'people#show'
  get '/people/a-z/:letter', to: 'people#letters'
end
