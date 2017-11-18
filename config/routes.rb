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

  post 'registra_face' => 'pages#registra_face', as: 'registra_usuario'
  post 'update_user' => 'pages#update_user', as: 'actualiza_info_usuario'

  get 'og_link' => 'pages#og_link', as: 'track_link'
  get 'issues/latest' => 'issues#latest', as: 'issue_latest'

  resources :issues, only: [:index, :show]
  get 'category/:slug' =>'pages#home',  as: 'pages_categories'
  root 'pages#home'
end
