Rails.application.routes.draw do
  Healthcheck.routes(self)
  scope :api, defaults: {format: :json} do
    # devise_for :users, skip: :all

    devise_for :users, controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"
    }
    namespace :v1 do
      resources :users
    end
  end
end
