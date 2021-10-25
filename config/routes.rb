Rails.application.routes.draw do
  root 'staticpages#home'

  get '/signup', to: 'users#new'
  get '/home', to: 'staticpages#home'
  get '/help', to: 'staticpages#help'
  get '/about', to: 'staticpages#about'
  get '/contact', to: 'staticpages#contact'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
