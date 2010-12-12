class Admin::UsersController < Admin::BaseController

  def index
    @role_array = Role.all.collect {|r| [r.name,r.id.to_s]}
    @search_fields_array = ["email"]
    #@users = User.search(params[:search], params[:page], get_search_field)
    if (params[:which_action].nil?) || (params[:which_action] == "Search")
      @users = User.my_search(params[:search], params[:page], get_search_field,"not_staff",[])
    else                # params[:which_action] == "Filter"
      @users = User.filter_by_status(params[:filter_by], params[:page], "role_id","not_staff",[])
    end
  end

  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to admin_users_path, :notice => "User account created and is ready for use."
    else
      render :action => 'new'
    end
  end

  def edit
    # only admins are going to access this under current assumptions
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User data was successfully updated.'
      if is_internal?
        redirect_to :action => "index"
      else
        redirect_to admin_edit_user_path(@user)
      end
    else
      render :action => "edit"
    end
  end

  def set_current_staff_user
    @current_staff_user = User.find(params[:id])
    session[:staff_user_id] = @current_staff_user.id
    flash[:notice] = "Current staff user set to #{current_staff_user.email}. Assign client permissions."
    redirect_to :controller => 'client_perms', :action => 'index'
  end

  def change_status
    @user = User.find(params[:id])
    @user.update_attribute(:active, (@user.active ? false : true))
    flash[:warning] = "Set user status to " + (@user.active ? "active" : "in-active") + " for " + @user.email
    redirect_to admin_users_path
  end

  def confirm_user
    @user = User.find(params[:id])
    if @user.active
      @user.confirm!
      flash[:warning] = "Confirming user #{@user.email}.  Be warned that the user can now log into the application"
    else
      flash[:warning] = "User is not active currently.  You should activate him first!"
    end
    redirect_to admin_users_path
  end
end
