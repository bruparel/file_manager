Factory.define :admin_role, :class => :role do |r|
  r.sequence(:name) { |n| "admin#{n}" }
  r.sequence(:display_name) { |n| "Administrator#{n}" }
end

Factory.define :leader_role, :class => :role do |r|
  r.sequence(:name) { |n| "leader#{n}" }
  r.sequence(:display_name) { |n| "Leader#{n}" }
end

Factory.define :staff_role, :class => :role do |r|
  r.sequence(:name) { |n| "staff#{n}" }
  r.sequence(:display_name) { |n| "Staff#{n}" }
end

#This creates an external client instance
Factory.define :eclient_role, :class => :role do |r|
  r.sequence(:name) { |n| "eclient#{n}" }
  r.sequence(:display_name) { |n| "External Client#{n}" }
end

Factory.define :admin_profile, :class => :profile do |p|
  p.first_name {'System'}
  p.last_name {'Administrator'}
end

Factory.define :lead_profile, :class => :profile do |p|
  p.first_name {'Big'}
  p.last_name {'Boss'}
end

Factory.define :staff_profile, :class => :profile do |p|
  p.first_name {'Humble'}
  p.last_name {'Hombre'}
end

# This will guess the User class
Factory.define :admin_user, :class => :user do |u|
  u.email {'system@example.com'}
  u.password {'important'}
  u.password_confirmation {'important'}
  u.profile { Factory.build(:admin_profile) } 
  u.association :role, :factory => :admin_role
end

# This will create a lead user instance
Factory.define :lead_user, :class => :user do |u|
  u.email {'lead@example.com'}
  u.password {'leader_pass'}
  u.password_confirmation {'leader_pass'}
  u.profile { Factory.build(:lead_profile) } 
  u.association :role, :factory => :leader_role
end

# This will create a lead user instance
Factory.define :staff_user, :class => :user do |u|
  u.email {'staff@example.com'}
  u.password {'staff_pass'}
  u.password_confirmation {'staff_pass'}
  u.profile { Factory.build(:staff_profile) } 
  u.association :role, :factory => :staff_role
end

# This will create an external client user instance
Factory.define :eclient_user, :class => :user do |u|
  u.email {'external@example.com'}
  u.password {'external'}
  u.password_confirmation {'external'}
  u.association :role, :factory => :eclient_role
  u.association :client, :factory => :client
end

# This creates an inactive_user instance
Factory.define :inactive_user, :parent => :admin_user do |u|
  u.active { false }
end

# This will guess the ClientStatus class
Factory.define :client_status do |cs|
  cs.sequence(:name) { |n| "Active#{n}" }
end

# This will guess the Client class
Factory.define :client do |pr|
  pr.sequence(:client_name) { |n| "Client Name#{n}" }
  pr.contact_name { 'Super Man'}
  pr.address1 {'1100 Main Street'}
  pr.city {'Newton'}
  pr.state {'Massachusetts'}
  pr.zip {'02459'}
  pr.phone {'111-111-1111'}
  pr.mobile {'222-222-2222'}
  pr.fax {'333-333-3333'}
  pr.comment {'This is a test client'}
  pr.association :client_status
end

# This will guess the ClientComment class
Factory.define :client_comment do |pc|
  pc.content { 'This is a test comment'}
  pc.delta { false }
  pc.association :client
  pc.association :user, :factory => :lead_user
end

# This will guess the ClientPerm class
Factory.define :client_perm do |pp|
  pp.association :client
  pp.association :user, :factory => :lead_user
end

Factory.define :base_folder do |f|
  f.name "base folder1"
end

# This will guess the Folder class
Factory.define :folder do |f|
  f.sequence(:name) { |n| "Referrals - #{n}" }
  f.eclient_flag { false }
  f.association :client
end

# This will guess the FolderPerm class
Factory.define :folder_perm do |fp|
  fp.association :user, :factory => :lead_user
  #fp.association :client
  fp.association :folder
end

# This will guess the Document class
Factory.define :document do |d|
  d.sequence(:title) { |n| "Document title #{n}" }
  d.description { 'This is a test document description'}
  d.doc_file_name { "#{Rails.root}/public/images/bl.png" }
  d.doc_content_type { 'image/jpeg' }
  d.association :document_status
  d.association :folder
end

# This will guess the DocumentStatus class
Factory.define :document_status do |ds|
  ds.sequence(:name) { |n| "Verified#{n}" }
end
