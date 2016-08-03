Rails.application.routes.draw do
  resources :tags
  root 'posts#index'

  resources :articles do
    resources :comments
  end

  resources :posts do
    resources :comments
  end
end
