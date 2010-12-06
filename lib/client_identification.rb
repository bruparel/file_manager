# Similar to (User) Authentication, but specific to Clients - Hence the separation
# Similar to (User) Authentication, include it into the Application Controller
module ClientIdentification

  def self.included(controller)
    controller.send :helper_method, :current_client, :current_client_selection_required, :current_folder
  end

  def current_client
    @current_client ||= Client.find(session[:client_id]) if session[:client_id]
  end

  def current_folder
    @current_folder ||= Folder.find(session[:folder_id]) if session[:folder_id]
  end

  def current_client_selection_required
    unless current_client
      if is_internal?
        flash[:error] = "You must first select a client before accessing this page."
        redirect_to clients_path
      else                   ## a client user
        flash[:error] = "You must first fill-in Basic Info before you can upload/download documents."
        redirect_to :controller => 'clients', :action => 'edit'
      end
    end
  end

  def current_client_and_folder_selection_required
    current_client_selection_required
    unless current_folder
      flash[:error] = "You must first select a folder before accessing this page."
      redirect_to folders_path
    end
  end

end
