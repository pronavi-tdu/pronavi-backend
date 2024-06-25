Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      post 'users/register', to: 'users#register'
      post 'users/check_mailaddress', to: 'users#check_mailaddress'
      get 'users/index', to: 'users#index'
      patch 'users/locations', to: 'users#locations'
      patch 'users/:user_id/schedules', to: 'schedules#update'
      patch 'users/schedules/details', to: 'schedules#update_detail'

      patch 'users/:user_id/department', to: 'users#update_user_department'
      patch 'users/:user_id/user_name', to: 'users#update_user_name'
    end
  end
end