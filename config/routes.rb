BmsApp::Application.routes.draw do
  root 'pages#home'


  get '/pages/:id-:alias' => 'pages#show', as: 'page'

  get 'news' => 'articles#index'
  get '/news/:id-:alias' => 'articles#show', as: 'article'

  get 'reviews' => 'reviews#index'

  get 'gallery' => 'photo_galleries#index'
  get '/galleries/:id-:alias' => 'photo_galleries#show', as: 'photo_gallery'

  get 'contacts' => 'feedbacks#new'
  resources :feedbacks

  get '/catalog' => 'catalog#index'
  get '/catalog/:id-:alias' => 'catalog#show_category', as: 'category'
  get '/catalog/:category_alias/:id-:alias' => 'catalog#show_product', as: 'product'

  get 'portfolio' => 'portfolio_objects#index'
  get '/portfolio/:id-:alias' => 'portfolio_objects#show', as: 'portfolio_object'

  get 'services' => 'services#index'
  get '/services/:id-:alias' => 'services#show', as: 'service'

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  get '/404' => 'errors#not_found'
  get '/422' => 'errors#server_error'
  get '/500' => 'errors#server_error'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
