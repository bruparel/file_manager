require 'open-uri'

class DocumentsController < ApplicationController

  before_filter :login_required
  before_filter :current_client_and_folder_selection_required

  def index
    @search_fields_array = ["title","doc_file_name"]
    @status_array = DocumentStatus.all.collect {|p| [p.name,p.id.to_s]}
    if (params[:which_action].nil?) || (params[:which_action] == "Search")
      @documents = current_folder.documents.my_search(params[:search], params[:page], get_search_field,"not_staff",[])
    elsif params[:which_action] == "Filter"
      @documents = current_folder.documents.filter_by_status(params[:filter_by], params[:page], "document_status_id","not_staff",[])
    end
  end

  def new
    @document = current_folder.documents.build
  end

  def create
    @document = current_folder.documents.build(params[:document])
    if @document.save
      redirect_to documents_path, :notice => "Successfully created document."
    else
      render :action => 'new'
    end
  end

  def edit
    @document = current_folder.documents.find(params[:id])
  end

  def update
    @document = current_folder.documents.find(params[:id])
    if @document.update_attributes(params[:document])
      flash[:notice] = "Successfully updated document."
      redirect_to documents_path, :notice => "Successfully updated document."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @document = current_folder.documents.find(params[:id])
    @document.destroy
    flash[:notice] = "Successfully deleted document."
    redirect_to documents_url, :notice => "Successfully deleted document."
  end

  def download_document
    @document = Document.find(params[:id])
    data = open(@document.doc.url(:original)).read
    send_data data, :filename => @document.doc.original_filename
  end

end
