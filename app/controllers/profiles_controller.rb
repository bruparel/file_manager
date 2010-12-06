class ProfilesController < ApplicationController

  def set_theme
    current_user.profile.update_attribute(:theme, params[:id])
    redirect_to :back, :notice => "Set the new theme to #{params[:id]}"
  end

  def toggle_help
    current_user.profile.update_attribute(:help_on, !current_user.profile.help_on)
    redirect_to :back, :notice => "System wide help has been turned " + (current_user.profile.help_on ? "on" : "off")
  end

  def reset
    session[:client_id] = nil if session[:client_id]
    session[:folder_id] = nil if session[:folder_id]
    redirect_to clients_path, :notice => "Current client unset.  Select a new client below."
  end

end
