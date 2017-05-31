require 'test_helper'

class OpenbattlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get openbattles_index_url
    assert_response :success
  end

  test "should get show" do
    get openbattles_show_url
    assert_response :success
  end

end
