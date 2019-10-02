Rails.application.routes.draw do
  resources :tournaments do
    resources :teams, only: %i[new create show]
  end

  post '/divisions/:id/generate_results', to: 'divisions#generate_results', as: :generate_division_results
  post '/playoffs/:id/generate_results', to: 'playoffs#generate_results', as: :generate_playoff_results

  root 'tournaments#index'
end
