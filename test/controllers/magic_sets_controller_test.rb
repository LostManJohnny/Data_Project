require "test_helper"

class MagicSetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index," do
    get magic_sets_index,_url
    assert_response :success
  end

  test "should get show" do
    get magic_sets_show_url
    assert_response :success
  end
end
