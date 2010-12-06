namespace :db do
  desc "Erase and fill client and folder tables with test data"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    [Client, Folder].each(&:delete_all)
    active_status_id = ClientStatus.find_by_name("Active").id
    Client.populate 20 do |client|
      client.client_name      = Faker::Company.name
      client.contact_name     = Faker::Name.name
      client.address1         = Faker::Address.street_address
      client.city             = Faker::Address.city
      client.state            = Faker::Address.us_state_abbr
      client.zip              = Faker::Address.zip_code
      client.phone            = Faker::PhoneNumber.phone_number
      client.mobile           = Faker::PhoneNumber.phone_number
      client.fax              = Faker::PhoneNumber.phone_number
      client.comment          = Populator.sentences(1..2)
      client.client_status_id = active_status_id
      i = 0
      Folder.populate 5..10 do |folder|
        folder.client_id = client.id
        i = i + 1
        folder.name = Populator.words(1..3).titleize + i.to_s 
      end
    end
    # now create the external user if he does not exist already
    user = User.find_or_create_by_email({:email => 'euser@example.com', :role_id => 4, :client_id => 1,
                                     :password => 'external_user',  :password_confirmation => 'external_user'})    
    user.confirm!
    profile = Profile.create(:first_name => "External", :last_name => "Client")
    user.profile = profile
    user.save!
  end
end
