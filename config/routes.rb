Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :institutions 
      resources :students 
      resources :enrollments 
      resources :bills
    end
  end
end
