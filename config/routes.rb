Rails.application.routes.draw do
  root to: "homes#index"
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

  namespace :tiktok_auth do
    get 'registrations/callback', to: "registrations#callback"
    get 'registrations/thanks', to: "registrations#thanks"
  end

  post "/graphql", to: "graphql#execute"

  namespace :admin do
    resources :companies
    resources :brands
    resources :products do
      delete :custom_product_image_destroy, to: 'products#destroy_image'
    end
    resources :campaigns
    resources :tiktok_movies
    resources :participation_tiktok_movies
    resources :campaign_participations
    resources :tiktok_movie_profiles
    resources :reference_tiktok_movies
    resources :rewards
    resources :users
    resources :user_profiles
    resources :tiktok_access_tokens
    resources :transfer_requests

    root to: "campaigns#index"
  end

end
