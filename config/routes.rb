Rails.application.routes.draw do
  resources :articles
  root 'posts#index'
  resources :posts do
    resources :comments
  end
end
