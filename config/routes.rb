Rails.application.routes.draw do
  resources :stories do
    resources :chapters
  end
  get "/stories/:story_id/chapters/:id/delete", to: "chapters#delete"
  root 'welcome#index'
end
