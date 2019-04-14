Rails.application.routes.draw do
  get 'home/front'
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
      
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

  resources :todo_lists do
    resources :todo_items do
    end
  end

  root :to => "home#front"
end
