Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  Healthcheck.routes(self)
  scope :api, defaults: {format: :json} do
    # devise_for :users, skip: :all

    devise_for :users, :class_name => 'User', controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"
    }

    devise_scope :user do
      post "users/confirm_email", to: "users/sessions#confirm_email"
    end

    namespace :v1 do
      resources :users
    end
  end
end
