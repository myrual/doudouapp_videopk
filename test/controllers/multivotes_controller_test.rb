require 'test_helper'

class MultivotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @multivote = multivotes(:one)
  end

  test "should get index" do
    get multivotes_url
    assert_response :success
  end

  test "should get new" do
    get new_multivote_url
    assert_response :success
  end

  test "should create multivote" do
    assert_difference('Multivote.count') do
      post multivotes_url, params: { multivote: {  } }
    end

    assert_redirected_to multivote_url(Multivote.last)
  end

  test "should show multivote" do
    get multivote_url(@multivote)
    assert_response :success
  end

  test "should get edit" do
    get edit_multivote_url(@multivote)
    assert_response :success
  end

  test "should update multivote" do
    patch multivote_url(@multivote), params: { multivote: {  } }
    assert_redirected_to multivote_url(@multivote)
  end

  test "should destroy multivote" do
    assert_difference('Multivote.count', -1) do
      delete multivote_url(@multivote)
    end

    assert_redirected_to multivotes_url
  end
end
