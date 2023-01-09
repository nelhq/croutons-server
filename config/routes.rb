Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/line_token_auth/registrations',
        sessions: 'api/v1/line_token_auth/sessions'
      }
    end
  end

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"

  namespace :admin do
    resources :users
    resources :brands
    resources :companies
    resources :products
    resources :campaigns
    resources :campaign_participations
    resources :tiktok_movies
    resources :participation_tiktok_movies

    root to: "campaigns#index"
  end

end
