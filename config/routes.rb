Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'auth/register',     to: 'authentication#register'
      post 'auth/authenticate', to: 'authentication#authenticate'
    end
  end
end
