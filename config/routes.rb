# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    resource :session, only: %i[new create destroy]

    resources :users, only: %i[new create edit update destroy]

    resources :questions do
      resources :comments, except: %i[new show]
    end

    root 'pages#index'
  end

  get '*path', to: redirect('/', status: 404)
end
