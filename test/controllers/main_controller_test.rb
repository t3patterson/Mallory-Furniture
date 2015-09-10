require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get multi" do
    get :multi
    assert_response :success
  end

  test "should get single" do
    get :single
    assert_response :success
  end

end
