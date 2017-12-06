Rails.application.routes.draw do
  namespace :admin do
    get 'log_in' => 'sessions#new', as: :log_in
    get 'log_out' => 'sessions#destroy', as: :log_out

    root 'articles#new'

    get 'articles/approved' => 'articles#approved', as: 'approved_articles'

    post 'articles/approve/:id' => 'articles#approve', as: 'approve_article'
    post 'articles/reject/:id' => 'articles#reject', as: 'reject_article'
    get 'articles/unauthorized' => 'articles#unauthorized', as: 'unauthorized'
    post 'sessions/' => 'sessions#create'

    resources :articles
    resources :categories
  end

  post 'registra_face' => 'users#registra_face', as: 'create_user'
  post 'update_user' => 'users#update_user', as: 'update_user_info'
  post 'user_assistance' => 'users#user_assistance', as: 'user_assistance'
  post 'check_newsletter' => 'users#check_newsletter', as: 'check_subscription'
  post 'subscribe_newsletter' => 'users#subscribe_newsletter', as: 'new_subscription'
  get 'article' => 'users#article', as: 'track_link'

  get 'aviso_de_privacidad' => 'pages#privacy_policy', as: 'privacy_policy'

  get 'issues/latest' => 'issues#latest', as: 'issue_latest'

  resources :issues, only: [:index, :show]
  get 'category/:slug' =>'pages#home',  as: 'pages_categories'
  root 'pages#home'
end
