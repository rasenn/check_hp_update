# coding : utf-8
require 'spec_helper'

describe User do
  context " when user create," do 
    before :each do
      User.delete_all
    end
    
    it "should be able to create." do
      User.create(:email => "admin@example.com" , :password => "adminadmin").id.should be_true
    end

    it "should not be able to create replicated adress." do
      User.create(:email => "admin@example.com" , :password => "adminadmin")
      User.create(:email => "admin@example.com" , :password => "adminadmin2").id.should_not be_true
    end

    it "should be can find." do 
      User.create( :id => 1 , :email => "admin@example.com" , :password => "adminadmin")
      User.where(:email => "admin@example.com").exists?.should be_true
    end
  end
  
  context "when add url," do 
    describe "collect url," do
      before do
        User.delete_all
        @user = User.create( :id => 1 , :email => "admin@example.com" , :password => "adminadmin")
      end
      
      it "can add existed url." do
        @user.add_url("http://galaxyheavyblow.web.fc2.com/")
        
      end
    end
  end
end
