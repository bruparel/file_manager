class Admin::ClientStatusesController < Admin::BaseController

  def index
    user_role = current_user.role.name
    perms = []
    @search_fields_array = ["name"]
    @client_statuses = ClientStatus.my_search(params[:search], params[:page], get_search_field, user_role, perms)
    render :layout => 'admin'
  end

  def show
    @client_status = ClientStatus.find(params[:id])  
    render :layout => 'admin'
  end

  def new
    @client_status = ClientStatus.new
    render :layout => 'admin'
  end

  def create
    @client_status = ClientStatus.new(params[:client_status])
    if @client_status.save
      redirect_to :admin_client_statuses, :notice => "Client status was successfully created."
    else
      render :action => 'new'
    end
  end

  def edit
    @client_status = ClientStatus.find(params[:id])
    render :layout => 'admin'
  end

  def update
    @client_status = ClientStatus.find(params[:id])
    if @client_status.update_attributes(params[:client_status])
      redirect_to :admin_client_statuses, :notice => "Client status was successfully updated."
    else
      render :action => "edit"
    end
  end

  def destroy
    @client_status = ClientStatus.find(params[:id])
    @client_status.destroy
    redirect_to :admin_client_statuses, :alert => "Client status sucessfully destroyed."
  end

end
