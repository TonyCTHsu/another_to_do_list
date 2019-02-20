Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :lists, only: [:index, :create, :edit, :update, :destroy] do
    member do
      put :toggle
    end
  end

  root to: 'lists#index'
end
