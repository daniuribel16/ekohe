Rails.application.routes.draw do
  namespace :v1 do
    resources :users, only: [:show, :create, :update]
    resources :books, only: [:show, :create]
    post '/books/income/:id', to: 'books#book_income'
    resources :book_transactions, only: [:create, :update]
  end
end
