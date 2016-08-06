Rails.application.routes.draw do
  resources :users do
    resources :subs, only: [:new]
  end
  resource :session

  resources :subs, except: [:new]

  resources :posts do
    resources :comments, only: [:new]
    post "upvote", on: :member
    post "downvote", on: :member
  end

  resources :comments, only: [:create, :show] do
    post "upvote", on: :member
    post "downvote", on: :member
  end
end
