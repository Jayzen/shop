Rails.application.routes.draw do
  root "welcomes#index"
  
  mount API::Base => '/api'
  mount GrapeSwaggerRails::Engine => '/api/doc'

  resources :images
  resources :categories
  resources :products
  resources :product_properties
  resources :product_images
  resources :banners
  resources :banner_items
  resources :users
  resources :user_addresses
  resources :themes do
    get 'products_manage', on: :member
    post 'add_product', on: :member
    get 'delete_product', on: :member
  end
end
