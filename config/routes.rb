Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: 'candidates#index'
    resources :candidates, only: [:new, :create, :index, :edit, :update, :show]
  end

  devise_scope :user do
    root controller: 'devise/sessions', action: 'new', as: :unauthenicated_root
  end
end
