Rails.application.routes.draw do
  root 'main#index'
  post '/' => 'main#encode'
  get '/:key' => 'main#redirect_key'
end
