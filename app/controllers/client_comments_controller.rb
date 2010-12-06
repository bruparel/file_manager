class ClientCommentsController < ApplicationController

  before_filter :current_client_selection_required
  before_filter :set_notes_tab

  def index
    @comments  = current_client.client_comments.search(params[:search] || "",
                                                           :page => params[:page] || 1, :per_page => 10,
                                                           :order => :created_at, :sort_mode => :desc,
                                                           :match_mode => :boolean)
    @client = current_client
  end

  def create
    @comment = ClientComment.create!(params[:client_comment])
    unless params[:send_email].nil?
      # wants to send the email
      commenting_user_id = @comment.user_id
      @client_user = @comment.client.user
      email_subject = params[:subject]
      email_text    = @comment.content
      send_email(@client_user, commenting_user_id, email_subject, email_text)
    end
    redirect_to :controller => 'client_comments', :action => 'index'
  end

  protected

  def set_notes_tab
    #self.class.current_tab :notes
  end

end
