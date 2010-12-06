# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  # Ryan's stripped down Authentication module from Restful_Authentication
  # Note: This has been replaced by Authlogic as of now.  Though I have kept
  # the modules for other helper methods that are used throughout the code
  include Authentication
  # And my own (Bharat's) ClientIdentification module patterned after Ryan's
  include ClientIdentification
  # User Identification module - has methods for supporting staff user permisssions
  include StaffUserIdentification
  # include States module for states drop-down in views
  include States
  # ssl requirement module
  #include SslRequirement

  before_filter :authenticate_user!

  helper :all # include all helpers, all the time

  helper_method :current_user_session, :current_user

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '4c04145687686bb4b16e86488abe7570'
  before_filter :load_current_theme

  def access_denied
    render_optional_error_file(401)
    return false
  end

  def get_search_field
    params[:search_by].nil? ? nil : params[:search_by].downcase.gsub(/\s/,'_')
  end

  protected

  def load_current_theme
    @current_theme = (logged_in? ? current_user.profile.theme : 'default')
  end

#  def ssl_required?
#    return false if ['development'].include?(Rails.env)
#    (ENV['Rails.env'] == "production" || !local_request?) && (self.class.read_inheritable_attribute(:ssl_required_actions) || []).include?(action_name.to_sym)
#  end

  def send_email(commented_on_user_model, commenting_user_id, email_subject, email_text)
    commenting_user = User.find(commenting_user_id)
    # create email and send it to right recipients depending on their roles
    if is_internal?
      # mail going from us to client
      UserMailer.comment_email_from_us(commented_on_user_model, commenting_user,
                                                 email_subject, email_text).deliver
    else
      # mail from client to us, get user email id
      UserMailer.comment_email_to_us(commented_on_user_model, commenting_user,
                                               email_subject, email_text).deliver
    end
  end

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    # def current_user
    #   return @current_user if defined?(@current_user)
    #   @current_user = current_user_session && current_user_session.record
    # end  

end
