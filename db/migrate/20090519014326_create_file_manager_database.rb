class CreateFileManagerDatabase < ActiveRecord::Migration
  
  def self.up
    # roles
    create_table :roles do |t|
      t.string :name
      t.string :display_name
    end
    # profiles
    create_table :profiles do |t|
      t.integer  :user_id
      t.string   :first_name
      t.string   :last_name
      t.string   :theme, :default => 'default'
      t.boolean  :help_on, :default => true
      t.timestamps
    end
    # client statuses
    create_table :client_statuses do |t|
      t.string :name
      t.timestamps
    end
    # category_perms
    create_table :client_perms do |t|
      t.column :user_id, :integer
      t.column :client_id, :integer
      t.timestamps
    end
    add_index :client_perms, :user_id
    add_index :client_perms, :client_id
    # client table
    create_table :clients do |t|
      t.column :client_name, :string
      t.column :contact_name, :string
      t.column :address1, :string
      t.column :address2, :string
      t.column :city, :string
      t.column :state, :string
      t.column :zip, :string
      t.column :phone, :string
      t.column :mobile, :string
      t.column :fax, :string
      t.column :comment, :text
      t.column :client_status_id, :integer
      t.column :permit, :boolean
      t.timestamps
    end
    add_index :clients, :client_status_id
    add_index :clients, :client_name
    add_index :clients, :city
    # client_comments
    create_table :client_comments do |t|
      t.column :content, :text, :default => ""
      t.column :client_id, :integer
      t.column :user_id, :integer
      t.column :delta, :boolean, :default => false
      t.timestamps
    end
    add_index :client_comments, :client_id
    add_index :client_comments, :user_id
    add_index :client_comments, :delta
    # base_folders
    create_table :base_folders do |t|
      t.string :name
      t.timestamps
    end
    # folders
    create_table :folders do |t|
      t.integer :parent_id
      t.string  :name
      t.integer :client_id
      t.boolean :permit
      t.boolean :eclient_flag, :default => false
      t.timestamps
    end
    add_index :folders, :parent_id
    add_index :folders, :client_id
    create_table :folder_perms do |t|
      t.column :user_id, :integer
      t.column :client_id, :integer
      t.column :folder_id, :integer
      t.timestamps
    end
    add_index :folder_perms, :user_id
    add_index :folder_perms, :client_id
    add_index :folder_perms, :folder_id    
    # documents
    create_table :documents do |t|
      t.column :folder_id, :integer
      t.column :document_status_id, :integer
      t.column :title, :string
      t.column :description, :text
      t.column :doc_file_name, :string
      t.column :doc_content_type, :string
      t.column :doc_file_size, :integer
      t.column :doc_updated_at, :datetime
      t.timestamps
    end
    add_index :documents, :document_status_id
    add_index :documents, :folder_id
    # document_statuses
    create_table :document_statuses do |t|
      t.string :name
      t.timestamps
    end  end

  def self.down
    drop_table :sessions
    drop_table :users
    drop_table :roles
    drop_table :documents
    drop_table :document_statuses
    drop_table :base_folders
    drop_table :folders
    drop_table :folder_perms
    drop_table :clients
    drop_table :client_comments
    drop_table :client_statuses
    drop_table :client_perms
  end
  
end
