# users' roles
[['admin','Administrator'],['leader','Leader'],['staff','Staff'],['eclient','External Client']].
    each { |r| Role.find_or_create_by_name(:name => r[0], :display_name => r[1]) }
# client statuses
['Active','Inactive'].each { |s| ClientStatus.find_or_create_by_name(:name => s) }
# document statuses
['Uploaded','Downloaded','Archived'].each { |s| DocumentStatus.find_or_create_by_name(:name => s) }
# Base folders
['Requirements','Specifications','Design', 'Invoices', 'Payments'].each { |t| BaseFolder.find_or_create_by_name(:name => t) }
# Start-up user accounts - Note that we cannot create the 'euser' = 'External Client User' account yet since
# it is dependent upon the existence of a client account who the 'euser' account can be assigned to.  Therefore,
# the 'euser' account will need to be created after running db:populate rake task which creates a number of clients
[['system@example.com',1,'important','System', 'Administrator'],
 ['leader@example.com',2,'leader','Big', 'Boss'],
 ['staff@example.com',3,'staff_user','Humble', 'Hombre']
].each do |u|
    params = {:user => {:email                 => u[0],
                        :role_id               => u[1],
                        :password              => u[2],
                        :password_confirmation => u[2], 
                        :profile_attributes    => {:first_name => u[3], :last_name => u[4]}}}

    user = User.create!(params[:user])

    user.confirm!                 # confirmation for devise
    
    # user.profile = profile
    # user.save!
end

