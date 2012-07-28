require 'test_helper'

class CheckUpdateControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get logout" do
    get :logout
    assert_response :success
  end

end
