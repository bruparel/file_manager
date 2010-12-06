FileManager::Application::routes.draw do

  devise_for :users
  root :to => 'welcome#index'

  namespace :admin do
    root :to => "base#index"
    resources :base_folders
    resources :client_statuses
    resources :client_perms do
      put :assign,                        :on => :collection
      get :set_current_staff_user_client, :on => :member
      get :delete_perms,                  :on => :member
    end
    resources :folder_perms do
      put :assign, :on => :collection
    end
    resources :document_statuses
    resources :users do
      get :change_status,          :on => :member
      get :confirm_user,           :on => :member
      get :set_current_staff_user, :on => :member
    end
  end

  resources :clients do
    get :set_current_client, :on => :member
  end
  resources :folders do
    get :set_current_folder, :on => :member
    get :nest,               :on => :member
    put :populate,           :on => :collection
  end
  resources :documents do
    get :download_document,  :on => :member
  end

  resources :client_comments

  match '/help',                     :to => 'profiles#toggle_help'
  match '/set_theme',                :to => 'profiles#set_theme'
  match '/reset',                    :to => 'profiles#reset'
  match 'basic_info',                :to => 'clients#edit'
  match 'notes',                     :to => 'client_comments#index'
  match 'display_privacy_statement', :to => 'welcome#display_privacy_statement'

end
