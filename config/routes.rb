Rails.application.routes.draw do
  resources :chapters
  get "chapters/:id/delete", to: "chapters#delete"
  root 'welcome#index'
end
