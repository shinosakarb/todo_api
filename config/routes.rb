Rails.application.routes.draw do
  resources :todos do
    member do
      put :active, to: 'todos/active#update'
      put :complete, to: 'todos/complete#update'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
