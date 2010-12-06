module ClientsHelper
  def folder_perms_exist?(userid,clientid)
    # FolderPerm.find(:first,:conditions => ["user_id = ? and client_id = ?",userid,clientid])
    FolderPerm.where("user_id = ? and client_id = ?",userid,clientid).first()
  end
end
