Rottenpotatoes::Application.routes.draw do
  get '/search', to: 'movies#search_tmdb', as: 'search_tmdb'

  resources :movies

  # map '/' to be a redirect to '/movies'
  root to: redirect('/movies')
end
