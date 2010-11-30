module AuthSpecHelperMethods 
  def should_authenticate_user
    @current_user = mock_model(User)
    controller.should_receive(:authenticate_user!)
    controller.stub!(:current_user).and_return(@current_user)
  end

  def should_require_admin
    @current_user.should_receive(:admin?).and_return(true)
  end

  def should_redirect_without_admin_premission
    @current_user.should_receive(:admin?).and_return(false)
    yield
    response.should redirect_to "/"
  end

end
