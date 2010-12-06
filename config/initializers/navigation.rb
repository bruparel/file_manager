RPH::Navigation::Builder.config do |navigation|

  navigation.define :admin do |menu|
    menu.item :clients
    menu.item :folders
    menu.item :documents
    #menu.item :client_comments, :text => "Notes"
    menu.item :users, :path => :admin_users_path
    menu.item :client_perms, :path => :admin_client_perms_path
    menu.item :folder_perms, :path => :admin_folder_perms_path
    menu.item :admin, :path => :admin_root_path
  end

  navigation.define :leader_or_staff do |menu|
    menu.item :clients
    menu.item :folders
    menu.item :documents
  end
  
  navigation.define :welcome do |menu|
    menu.item :welcome, :path => :root_path
  end

  navigation.define :second_level_admin do |menu|
    menu.item :client_statuses, :path => :admin_client_statuses_path
    menu.item :document_statuses, :path => :admin_document_statuses_path
    menu.item :base_folders, :path => :admin_base_folders_path
  end
  
end
