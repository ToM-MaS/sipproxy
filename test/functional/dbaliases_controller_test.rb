require 'test_helper'

class DbaliasesControllerTest < ActionController::TestCase
  setup do
    @dbalias = Factory.create(:dbalias)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dbaliases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dbalias" do
    assert_difference('Dbalias.count') do
      post :create, :dbalias => Factory.attributes_for(:dbalias) 
    end

    assert_redirected_to dbalias_path(assigns(:dbalias))
  end

  test "should show dbalias" do
    get :show, :id => @dbalias.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @dbalias.to_param
    assert_response :success
  end

  test "should update dbalias" do
    put :update, :id => @dbalias.to_param, :dbalias => @dbalias.attributes
    assert_redirected_to dbalias_path(assigns(:dbalias))
  end

  test "should destroy dbalias" do
    assert_difference('Dbalias.count', -1) do
      delete :destroy, :id => @dbalias.to_param
    end

    assert_redirected_to dbaliases_path
  end
end
