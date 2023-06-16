Rails.application.routes.draw do
  devise_for :users


  unauthenticated do
    root "home#index" , as: :unauthenticated_root
  end


  authenticated :user do
    root 'articles#index', as: :authenticated_root
  end

  devise_scope :user do
    get :logout, to: "devise/sessions#destroy"
  end


  resources :articles
  resources  :home, only: [:index, :show]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
   
end
