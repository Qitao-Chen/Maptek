require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get accounts_login_url
    assert_response :success
  end

  test "should get register" do
    get accounts_register_url
    assert_response :success
  end

end
