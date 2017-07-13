Rails.application.routes.draw do
  root "pages#home"
  get 'pages/home', to: 'pages#home'
  
  get '/signup', to: 'users#new'
  resources :users, except: [:new]

  get 'pages/searchresults', to: 'pages#searchresults'
  
  get 'pages/movie', to: 'pages#movie'
end
