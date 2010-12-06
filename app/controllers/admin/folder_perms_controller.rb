class Admin::FolderPermsController < Admin::BaseController

  before_filter :current_staff_user_and_client_selection_required

  def index
    #self.class.current_tab :folder_perms
    uid = current_staff_user.id
    pid = current_staff_user_client.id
    Folder.update_all("permit = 0",["client_id = ?",pid])
    # Loop thru all the records in the folder_perms table for this staff user and turn on the permit
    # flag in folders table for those folders which exist for this staff user
    FolderPerm.find_all_by_user_id_and_client_id(uid,pid).each do |f|
      folder = Folder.find(f.folder_id)
      folder.update_attribute(:permit, true)
    end
    # display all folders for staff user permission assignment - no pagination
    @folders = Folder.where("client_id = ?", pid).order("parent_id")
  end

  def assign
    # params.inspect
    uid = current_staff_user.id
    pid = current_staff_user_client.id
    # save the user assigned perms array from params hash in new_perms array
    new_perms = params[:folder_ids]
    # make sure to check for the parent folders recursively and maintain those permissions
    new_perms.each do |f|
      folder = Folder.find(f)
      parent_folder_id = folder ? folder.parent_id : nil
      while parent_folder_id
        new_perms << parent_folder_id
        folder = Folder.find(parent_folder_id)
        parent_folder_id = folder ? folder.parent_id : nil
      end
    end
    # collect the existing perms for this user and client in existing_perms array
    existing_perms = FolderPerm.find_all_by_user_id_and_client_id(uid,pid).map {|f| f.folder_id}
    # find those perms from existing_perms that the user does not want any more and delete them
    delete_perms = existing_perms - new_perms
    # delete perms need to be wiped out from folder_perms table
    delete_perms.each do |f|
      delete_rec = FolderPerm.find_by_user_id_and_client_id_and_folder_id(uid,pid,f)
      FolderPerm.delete(delete_rec.id)
    end
    # find those perms from new perms that need to be added to the database
    add_perms = new_perms - existing_perms
    # add these perms to the database
    add_perms.each do |f|
      if FolderPerm.find_all_by_user_id_and_client_id_and_folder_id(uid,pid,f).size == 0
        FolderPerm.create!(:user_id => uid, :client_id => pid, :folder_id => f)
      end
    end
    # coming out, permissions should be all set, display flash message and navigate accordingly
    redirect_to :action => 'index', :notice => "Permissions assigned as shown."
  end

end
