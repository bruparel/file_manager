module ActiveRecord

  class Base
    def self.my_search(search, current_page, search_field, user_role, perms)
      if search.blank?
        if user_role == 'staff'
          paginate(:all, :conditions => ["id in (?)", perms], :page => current_page || 1, :per_page => 10)
        else
          paginate(:all, :page => current_page || 1, :per_page => 10)
        end
      else
        if user_role == 'staff'
          paginate(:all, :conditions => ["#{search_field} LIKE ? and id in (?)", "%#{search}%", perms],
                   :order => search_field, :page => current_page || 1, :per_page => 10)
        else
          paginate(:all, :conditions => ["#{search_field} LIKE ?", "%#{search}%"], :order => search_field,
            :page => current_page || 1, :per_page => 10)
        end
      end
    end

    def self.filter_by_status(filter, current_page, filter_field, user_role, perms)
      if user_role == 'staff'
        paginate(:all, :conditions => ["#{filter_field} = ? and id in (?)", filter, perms], 
                 :page => current_page || 1, :per_page => 10)
      else
        paginate(:all, :conditions => ["#{filter_field} = ?", filter], :page => current_page || 1, :per_page => 10)
      end
    end

  end

end
