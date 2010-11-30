module AuthSpecHelperMethods 
  def should_authenticate_user
    @current_user = mock_model(User)
    controller.should_receive(:authenticate_user!)
    controller.stub!(:current_user).and_return(@current_user)
  end
end
