module ControllerMacros
  def sign_in
    before(:each) do
      current_user = create(:user)

      controller.instance_variable_set(:@current_user, current_user)
    end
  end
end
