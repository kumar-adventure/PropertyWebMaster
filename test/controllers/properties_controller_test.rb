require 'test_helper'

class PropertiesControllerTest < ActionController::TestCase
  setup do
    @property = properties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:properties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create property" do
    assert_difference('Property.count') do
      post :create, property: { address: @property.address, available_from: @property.available_from, bathrooms: @property.bathrooms, bed_rooms: @property.bed_rooms, city: @property.city, district: @property.district, flooring: @property.flooring, furnishing: @property.furnishing, landmark: @property.landmark, location: @property.location, open_for_inspection: @property.open_for_inspection, parking: @property.parking, price: @property.price, property_for: @property.property_for, property_in: @property.property_in, short_desc: @property.short_desc, size: @property.size, title: @property.title, total_no_of_floors: @property.total_no_of_floors, total_rooms: @property.total_rooms, zipcode: @property.zipcode }
    end

    assert_redirected_to property_path(assigns(:property))
  end

  test "should show property" do
    get :show, id: @property
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @property
    assert_response :success
  end

  test "should update property" do
    patch :update, id: @property, property: { address: @property.address, available_from: @property.available_from, bathrooms: @property.bathrooms, bed_rooms: @property.bed_rooms, city: @property.city, district: @property.district, flooring: @property.flooring, furnishing: @property.furnishing, landmark: @property.landmark, location: @property.location, open_for_inspection: @property.open_for_inspection, parking: @property.parking, price: @property.price, property_for: @property.property_for, property_in: @property.property_in, short_desc: @property.short_desc, size: @property.size, title: @property.title, total_no_of_floors: @property.total_no_of_floors, total_rooms: @property.total_rooms, zipcode: @property.zipcode }
    assert_redirected_to property_path(assigns(:property))
  end

  test "should destroy property" do
    assert_difference('Property.count', -1) do
      delete :destroy, id: @property
    end

    assert_redirected_to properties_path
  end
end
