class Admin::ClientPermsController < Admin::BaseController
  before_filter :current_staff_user_selection_required

  def index
    Client.update_all("permit = 0")
    # Loop thru all the records in the client_perms table for this staff user and turn on the permit
    # flag in clients table for those clients which exist for this staff user
    ClientPerm.find_all_by_user_id(current_staff_user.id).each do |p|
      client = Client.find(p.client_id)
      client.update_attribute(:permit, true)
    end
    # display all clients for staff user permission assignment
    @clients = Client.all
  end

  def assign
    # params.inspect
    uid = current_staff_user.id
    # save the user assigned perms array from params hash in new_perms array
    new_perms = params[:client_ids]
    # collect the existing perms for this user in existing_perms array
    existing_perms = ClientPerm.find_all_by_user_id(uid).map {|p| p.client_id}
    # find those perms from existing_perms that the user does not want any more and delete them
    delete_perms = existing_perms - new_perms
    # delete perms need to be wiped out from client_perms table, check if any folder permissions
    # exist for this client set first
    delete_perms.each do |pr|
      delete_rec = ClientPerm.find_by_user_id_and_client_id(uid,pr)
      # delete any folder permissions for this user_id and client_id combo in FolderPerms
      FolderPerm.delete_all(["user_id = ? and client_id = ?",uid,pr])
      ClientPerm.delete(delete_rec.id)
    end
    # find those perms from new perms that need to be added to the database
    add_perms = new_perms - existing_perms
    # add these perms to the database
    add_perms.each do |pr|
      ClientPerm.create!(:user_id => uid, :client_id => pr)
    end
    # coming out, permissions should be all set, display flash message and navigate accordingly
    redirect_to :action => 'index', :notice => "Permissions assigned as shown."
  end

  def set_current_staff_user_client
    @client = Client.find(params[:id])
    session[:staff_user_client_id] = @client.id
    flash[:notice] = "Current client set to #{@client.client_name}. Assign permissions for the desired folders."
    redirect_to admin_folder_perms_path, :notice => "Current client set to #{@client.client_name}. Assign permissions for the desired folders."
  end

  def delete_perms
    FolderPerm.delete_all(["user_id = ? and client_id = ?",current_staff_user.id,params[:id]])
    redirect_to :action => 'list_perms'
  end

end
