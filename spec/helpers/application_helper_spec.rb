require File.expand_path("../../spec_helper.rb", __FILE__)

describe ApplicationHelper do

  describe "#auth_menu" do

    it "should show sign_in and sign_up link when user is not logged in" do
      helper.stub!(:user_signed_in?).and_return(false)
      menu = helper.auth_menu

      menu.should =~ /#{new_user_session_path}/
      menu.should =~ /#{new_user_registration_path}/
      menu.should_not =~ /#{destroy_user_session_path}/
    end

    it "should show sign_out link when user is logged in" do
      user = mock_model(User)
      user.stub!(:email).and_return("hello@abc.com")

      helper.stub!(:user_signed_in?).and_return(true)
      helper.stub!(:current_user).and_return(user)

      menu = helper.auth_menu

      menu.should_not =~ /#{new_user_session_path}/
      menu.should_not =~ /#{new_user_registration_path}/
      menu.should =~ /#{destroy_user_session_path}/
    end

  end

end
