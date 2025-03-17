require "test_helper"

class RelationshipGroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get relationship_groups_index_url
    assert_response :success
  end
end
