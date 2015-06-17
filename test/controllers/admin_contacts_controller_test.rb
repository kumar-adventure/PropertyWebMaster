require 'test_helper'

class AdminContactsControllerTest < ActionController::TestCase
  setup do
    @admin_contact = admin_contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_contact" do
    assert_difference('AdminContact.count') do
      post :create, admin_contact: { contact_no: @admin_contact.contact_no, email: @admin_contact.email, message: @admin_contact.message, name: @admin_contact.name }
    end

    assert_redirected_to admin_contact_path(assigns(:admin_contact))
  end

  test "should show admin_contact" do
    get :show, id: @admin_contact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_contact
    assert_response :success
  end

  test "should update admin_contact" do
    patch :update, id: @admin_contact, admin_contact: { contact_no: @admin_contact.contact_no, email: @admin_contact.email, message: @admin_contact.message, name: @admin_contact.name }
    assert_redirected_to admin_contact_path(assigns(:admin_contact))
  end

  test "should destroy admin_contact" do
    assert_difference('AdminContact.count', -1) do
      delete :destroy, id: @admin_contact
    end

    assert_redirected_to admin_contacts_path
  end
end
