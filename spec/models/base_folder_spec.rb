require 'spec_helper'

describe BaseFolder do

  describe "validate name" do
    it "Base folder cannot be saved without a name" do
      base_folder = Factory.build(:base_folder, :name => '')
      base_folder.should have(1).error_on(:name)
      base_folder.should_not be_valid
    end
    it "Base folder should be valid with a name" do
      base_folder = Factory.create(:base_folder)
      base_folder.should be_valid 
    end
    it "Base folder should enforce uniquness constraint on name" do
      base_folder1 = Factory.create(:base_folder)
      base_folder2 = Factory.build(:base_folder)
      base_folder2.should have(1).error_on(:name)
      base_folder2.should_not be_valid
    end
  end

end
