Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get :about, to: 'static_pages#about'
  get :signup,       to: 'users#new'
  get :memo_search, to: 'memos#memo_search'
  resources :users
  resources :memos
  resources :calendars
  get    :login,     to: 'sessions#new'
  post   :login,     to: 'sessions#create'
  delete :logout,    to: 'sessions#destroy'
end
