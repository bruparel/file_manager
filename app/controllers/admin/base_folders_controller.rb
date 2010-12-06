class Admin::BaseFoldersController < Admin::BaseController

  def index
    user_role = current_user.role.name
    perms = []
    @search_fields_array = ["name"]
    @base_folders = BaseFolder.my_search(params[:search], params[:page], get_search_field, user_role, perms)
    render :layout => 'admin'
  end

  def show
    @base_folder = BaseFolder.find(params[:id])  
    render :layout => 'admin'
  end

  def new
    @base_folder = BaseFolder.new
    render :layout => 'admin'
  end

  def create
    @base_folder = BaseFolder.new(params[:base_folder])
    if @base_folder.save
      redirect_to :admin_base_folders, :notice => "Base folder was successfully created."
    else
      render :action => 'new'
    end
  end

  def edit
    @base_folder = BaseFolder.find(params[:id])
    render :layout => 'admin'
  end

  def update
    @base_folder = BaseFolder.find(params[:id])
    if @base_folder.update_attributes(params[:base_folder])
      redirect_to :admin_base_folders, :notice => "Base folder was successfully updated."
    else
      render :action => "edit"
    end
  end

  def destroy
    @base_folder = BaseFolder.find(params[:id])
    @base_folder.destroy
    redirect_to :admin_base_folders, :alert => "Base folder sucessfully destroyed."
  end

end
