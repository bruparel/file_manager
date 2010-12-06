module StaffUserIdentification

  def self.included(controller)
    controller.send :helper_method, :current_staff_user, :current_staff_user_selection_required,
                    :current_staff_user_client, :current_staff_user_and_client_selection_required
  end

  def current_staff_user
    @current_staff_user ||= User.find(session[:staff_user_id]) if session[:staff_user_id]
  end

  def current_staff_user_client
    @current_staff_user_client ||= Client.find(session[:staff_user_client_id]) if session[:staff_user_client_id]
  end

  def current_staff_user_selection_required
    unless current_staff_user
      flash[:error] = "You must first select a staff user before accessing this page."
      redirect_to :controller => 'users', :action => 'index'
    end
  end

  def current_staff_user_and_client_selection_required
    user_str = (current_staff_user ? "a staff user and " : "")
    unless current_staff_user_client
      flash[:error] = "You must first select #{user_str} a client for this staff user before accessing this page."
      redirect_to :controller => 'clients', :action => 'index'
    end
  end

end
