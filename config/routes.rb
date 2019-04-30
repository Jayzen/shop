Rails.application.routes.draw do
  root "welcomes#index"
  
  mount API::Base => '/api'
  mount GrapeSwaggerRails::Engine => '/api/doc'

  resources :images
  resources :categories
  resources :products do
    resources :product_properties
    resources :product_images
  end
  resources :banners do
    resources :banner_items
  end
  resources :users
  resources :user_addresses
  resources :orders
  resources :order_products
  resources :themes do
    get 'products_manage', on: :member
    post 'add_product', on: :member
    get 'delete_product', on: :member
  end
end
