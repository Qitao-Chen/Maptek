require 'test_helper'

class AdministraterControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get administrater_main_url
    assert_response :success
  end

end
