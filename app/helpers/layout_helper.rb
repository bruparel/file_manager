# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args.map(&:to_s)) }
  end

  def javascript(*args)
    args = args.map { |arg| arg == :defaults ? arg : arg.to_s }
    content_for(:head) { javascript_include_tag(*args) }
  end

  # helper returns the currently logged in user's name
  def show_current_user
    return "" unless logged_in?
    display_name = current_user.profile.first_name + " " + current_user.profile.last_name
    "User: #{display_name} - (#{current_user.role.display_name})"
  end

  #helper returns currently selected client's full-name or businesses' name
  def show_current_client
    return "" unless logged_in? && current_client 
    "Client: #{current_client.client_name}"
  end

end
