Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'translate#index'
  post 'translate' => 'translate#index'
  get 'translate' => 'translate#index'
  get 'temp' => 'translate#temp'
end
