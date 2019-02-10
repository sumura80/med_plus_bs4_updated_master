Rails.application.routes.draw do
  get 'about' ,to:'pages#about'
  get 'terms' , to:'pages#terms'
  get 'privacy' , to:'pages#privacy'

  devise_for :users
  # devise_for :users, controllers: { sessions: 'users/sessions' } 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do 
  	resources :likes, only: [:create, :destroy]
  	resources :comments do
	  	resources :votes, only: [:create, :destroy]
	  end
  end


  root 'categories#index'
  
  get 'categories/pain_relief' ,to: 'categories#pain_relief'
  get 'categories/allergy' ,to: 'categories#allergy'
  get 'categories/cold_flu' ,to: 'categories#cold_flu'
  get 'categories/digestive' ,to: 'categories#digestive'

  #userのshowページ作成URL
  resources :users, only:[:show, :edit, :update]
  root 'posts#index'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  


end
