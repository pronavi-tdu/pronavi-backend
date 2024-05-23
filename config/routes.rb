Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      post 'users/register', to: 'users#register'
      get 'users/index', to: 'users#index'
      patch '/users/:user_id/schedules', to: 'schedules#update'
    end
  end
end