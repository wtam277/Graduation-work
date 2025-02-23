require "test_helper"

class StoryPartsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get story_parts_index_url
    assert_response :success
  end

  test "should get create" do
    get story_parts_create_url
    assert_response :success
  end

  test "should get update" do
    get story_parts_update_url
    assert_response :success
  end
end
