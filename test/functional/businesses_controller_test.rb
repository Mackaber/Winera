require 'test_helper'

class BusinessesControllerTest < ActionController::TestCase
  setup do
    @business = businesses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:businesses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create business" do
    assert_difference('Business.count') do
      post :create, business: { category: @business.category, description: @business.description, image: @business.image, lat: @business.lat, long: @business.long, name: @business.name, phone: @business.phone, schedule: @business.schedule, streetadr: @business.streetadr }
    end

    assert_redirected_to business_path(assigns(:business))
  end

  test "should show business" do
    get :show, id: @business
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @business
    assert_response :success
  end

  test "should update business" do
    put :update, id: @business, business: { category: @business.category, description: @business.description, image: @business.image, lat: @business.lat, long: @business.long, name: @business.name, phone: @business.phone, schedule: @business.schedule, streetadr: @business.streetadr }
    assert_redirected_to business_path(assigns(:business))
  end

  test "should destroy business" do
    assert_difference('Business.count', -1) do
      delete :destroy, id: @business
    end

    assert_redirected_to businesses_path
  end
end
