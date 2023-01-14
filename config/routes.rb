Rails.application.routes.draw do
  root to: "homes#index"
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/line_token_auth/registrations',
        sessions: 'api/v1/line_token_auth/sessions'
      }
      namespace :tiktok_auth do
        get 'registrations/new', to: "registrations#new"
        get 'registrations/callback', to: "registrations#callback"
      end
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
