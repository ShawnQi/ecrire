Ecrire::Application.routes.draw do
  root 'posts#index'

  get '/:year/:month/:id', controller: :posts, action: :show, constraints: { year: /\d+/, month: /\d+/ }, as: "post"
  get '/feed', controller: :posts, action: :index, defaults: { format: :rss }

  resources :posts, only: [:index]

  resource :session, only: [:new, :create, :destroy]

  resources :partials, only: [:show]

  namespace :admin do
    root 'posts#index'
    resources :posts do
      collection do
        get 'help', controller: :posts, action: :help
      end
      resources :tags, only: [:index, :update], module: 'posts'
      resources :titles, shallow: true
      resource :image, shallow: true
      resource :properties, only: [:create, :destroy]
    end

    resources :tags, only: [:edit, :create, :update, :destroy]

    namespace :configurations do
      resource :images, only: [:show, :create]
    end
  end

  get '/:view', to: 'static#show'

end
