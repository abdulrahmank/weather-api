Rails.application.routes.draw do
  resources :weather, only: %i[create index] do
  end

  delete '/erase' => 'weather#delete'
end
