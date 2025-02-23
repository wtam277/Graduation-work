require "test_helper"

class StoryMapsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get story_maps_index_url
    assert_response :success
  end
end
