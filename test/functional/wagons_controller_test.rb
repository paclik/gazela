require 'test_helper'

class WagonsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wagons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wagon" do
    assert_difference('Wagon.count') do
      post :create, :wagon => { }
    end

    assert_redirected_to wagon_path(assigns(:wagon))
  end

  test "should show wagon" do
    get :show, :id => wagons(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => wagons(:one).to_param
    assert_response :success
  end

  test "should update wagon" do
    put :update, :id => wagons(:one).to_param, :wagon => { }
    assert_redirected_to wagon_path(assigns(:wagon))
  end

  test "should destroy wagon" do
    assert_difference('Wagon.count', -1) do
      delete :destroy, :id => wagons(:one).to_param
    end

    assert_redirected_to wagons_path
  end
end
