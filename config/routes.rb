Rails.application.routes.draw do
  get 'home/front'
  devise_for :users

  resources :todo_lists do
  	resources :todo_items do
  		member do
  			patch :complete
        patch :deadline
        get :deadline
        put :move_up
        put :move_down
  		end
  	end
  end
  #=end

  resources :users do
    resources :todo_lists do
      resources :todo_items do
        member do
          patch :complete
          patch :deadline
          get :deadline
          put :move_up
          put :move_down
        end
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root "todo_lists#index"
  root :to => "home#front"
end
