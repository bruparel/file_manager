class ClientsController < ApplicationController

  before_filter :login_required
  before_filter :set_basic_info_tab

  def index
    if current_client && is_eclient?     # external client logged in
      redirect_to :action => 'edit', :id => current_client.id
      return
    end
    user_role = current_user.role.name
    perms     = ClientPerm.find_all_by_user_id(current_user.id).map {|p| p.client_id}
    @status_array = ClientStatus.all.collect {|p| [p.name,p.id.to_s]}
    @search_fields_array = ["client_name","contact_name","city"]
    if (params[:which_action].nil?) || (params[:which_action] == "Search")
      @clients = Client.my_search(params[:search], params[:page], get_search_field, user_role, perms)
    else                # params[:which_action] == "Filter"
      @clients = Client.filter_by_status(params[:filter_by], params[:page], "client_status_id", user_role, perms)
    end
  end

  def new
    @client = Client.new
    @client.client_status = ClientStatus.find_by_name('Active')
    @client.state = 'TX'
  end

  def edit
    if is_eclient?    # client accessing this form
      # may or may not yet have a record, check and setup @client accordingly
      if current_user.client
        @client = Client.find(current_user.client_id)
      else
        redirect_to login_path, :notice => "Please ask the Admin to setup your client."
      end
    else                # admin accessing this form, normal find is ok
      @client = Client.find(params[:id])
    end
  end

  def show
    @client = Client.find(params[:id])
  end

  def create
    @client = Client.new(params[:client])
    if @client.save
      session[:client_id] = @client.id
      redirect_to folders_path, :notice => 'Basic Info successfully saved. Please proceed to create folders to store documents.'
    else
      render :action => (is_internal? ? 'new' : 'edit')
    end
  end

  def update
    @client = Client.find(params[:id])
    @client.user = current_user if is_eclient?
    if @client.update_attributes(params[:client])
      session[:client_id] = @client.id
      flash[:notice] = 'Client data was successfully updated.'
      redirect_to(is_internal? ? clients_path : edit_client_path(@client))
    else
      render :action => "edit"
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to clients_path, :alert => "Successfully destroyed client record."
  end

  def set_current_client
    @client = Client.find(params[:id])
    session[:folder_id] = nil
    session[:nested_folder_id] = nil
    session[:client_id] = @client.id
    redirect_to folders_path, :notice => "Current client set to #{current_client.client_name}. Select the desired folder by clicking on set link."
  end

  protected

  def set_basic_info_tab
    #self.class.current_tab :basic_info if is_eclient?
  end

end
