class FoldersController < ApplicationController

  before_filter :login_required
  before_filter :current_client_selection_required

  def index
    if current_client.folders.blank?    # does not have any folders yet, show base folders
      # and allow to select desired set of folders as a base to start with which they can
      # later customize, i.e., add/edit/delete to this base starter set
      @base_folders = BaseFolder.all
    else                                  # folders exist, resume normal processing
      perms = FolderPerm.find_all_by_user_id_and_client_id(current_user.id,current_client.id).map {|f| f.folder_id}
      @search_fields_array = ["name"]
      @folder = (current_folder ? current_folder : nil)
      if current_user.role.name == 'staff'
        @folders = current_client.folders.sibling_folders(get_parent_id).
                   paginate(:all, :conditions => ["id in (?)", perms], :page => params[:page] || 1, :per_page => 10)        
      else
        @folders = current_client.folders.sibling_folders(get_parent_id).
                          paginate :page => params[:page] || 1, :per_page => 10
      end
    end
  end

  def show
    @folder = Folder.find(params[:id])
  end

  def new
    @parent_id = get_parent_id
    @folder = current_client.folders.build
  end

  def create
    @folder = current_client.folders.build(params[:folder])
    if @folder.save
      session[:folder_id] = @folder.id
      session[:nested_folder_id] = nil
      redirect_to folders_url, :notice => "Successfully created folder."
    else
      render :action => 'new'
    end
  end

  def edit
    @folder = current_client.folders.find(params[:id])
  end

  def update
    @folder = current_client.folders.find(params[:id])
    if @folder.update_attributes(params[:folder])
      session[:folder_id] = @folder.id
      session[:nested_folder_id] = nil
      redirect_to folders_url, :notice => "Successfully updated folder."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @folder = current_client.folders.find(params[:id])
    @folder.destroy
    redirect_to folders_url, :notice => "Successfully deleted folder."
  end

  def populate
    # this will transer the selected base folders  to the client folders as a
    # starting point
    unless params[:folder_ids].blank?
      params[:folder_ids].each do |selected_folder|
        base_folder = BaseFolder.find(selected_folder)
        current_client.folders.create!(:name => base_folder.name)
      end
    end
    redirect_to folders_path
  end

  def set_current_folder
    @folder = Folder.find(params[:id])
    session[:nested_folder_id] = nil
    unless @folder.client_id.blank?
      session[:folder_id] = @folder.id
      redirect_to documents_path, :notice => "Current folder set to #{current_folder.name}"
    else             # this should not happen, yet just in case
      redirect_to edit_folder_path(@folder), :alert => "Please associate this folder with corresponding client first."
    end
  end

  def nest
    @folder = Folder.find(params[:id])
    session[:folder_id] = @folder.id
    session[:nested_folder_id] = @folder.id
    redirect_to folders_path
  end

  private

  def get_parent_id
    parent_id = nil
    parent_id = (session[:nested_folder_id] ? current_folder.id : current_folder.parent_id) if current_folder
    parent_id
  end

end
