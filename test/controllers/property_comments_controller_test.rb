require 'test_helper'

class PropertyCommentsControllerTest < ActionController::TestCase
  setup do
    @property_comment = property_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:property_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create property_comment" do
    assert_difference('PropertyComment.count') do
      post :create, property_comment: { content: @property_comment.content, property_id: @property_comment.property_id, user_id: @property_comment.user_id }
    end

    assert_redirected_to property_comment_path(assigns(:property_comment))
  end

  test "should show property_comment" do
    get :show, id: @property_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @property_comment
    assert_response :success
  end

  test "should update property_comment" do
    patch :update, id: @property_comment, property_comment: { content: @property_comment.content, property_id: @property_comment.property_id, user_id: @property_comment.user_id }
    assert_redirected_to property_comment_path(assigns(:property_comment))
  end

  test "should destroy property_comment" do
    assert_difference('PropertyComment.count', -1) do
      delete :destroy, id: @property_comment
    end

    assert_redirected_to property_comments_path
  end
end
