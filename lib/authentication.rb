# This module is included in your application controller which makes
# several methods available to all controllers and views. Here's a
# common example you might add to your application layout file.
# 
#   <% if logged_in? %>
#     Welcome <%= current_user.email %>! Not you?
#     <%= link_to "Log out", logout_path %>
#   <% else %>
#     <%= link_to "Sign up", signup_path %> or
#     <%= link_to "log in", login_path %>.
#   <% end %>
# 
# You can also restrict unregistered users from accessing a controller using
# a before filter. For example.
# 
#   before_filter :login_required, :except => [:index, :show]
module Authentication
  def self.included(controller)
    controller.send :helper_method, :logged_in?, :login_required, :is_admin?,
                                    :is_leader?, :is_staff?, :is_internal?, :is_eclient?
  end
  
  def logged_in?
    user_signed_in? && current_user.active?
  end

  def is_admin?
    logged_in? && current_user.role.name == 'admin'
  end

  def is_leader?
    logged_in? && current_user.role.name == 'leader'
  end

  def is_staff?
    logged_in? && current_user.role.name == 'staff'
  end

  def is_internal?
    crn = current_user.role.name
    logged_in? && (crn == 'admin' || crn == 'leader' || crn == 'staff')
  end

  def is_eclient?
    logged_in? && current_user.role.name == 'eclient'
  end

  def login_required
    unless logged_in?
      flash[:error] = "You must first log in or sign up before accessing this page."
      redirect_to root_path
    end
  end
  
end
