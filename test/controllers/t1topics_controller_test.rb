require 'test_helper'

class T1topicsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @t1topic = t1topics(:one)
  end

  test "should get index" do
    get t1topics_url
    assert_response :success
  end

  test "should get new" do
    get new_t1topic_url
    assert_response :success
  end

  test "should create t1topic" do
    assert_difference('T1topic.count') do
      post t1topics_url, params: { t1topic: { order: @t1topic.order, running: @t1topic.running, title: @t1topic.title } }
    end

    assert_redirected_to t1topic_url(T1topic.last)
  end

  test "should show t1topic" do
    get t1topic_url(@t1topic)
    assert_response :success
  end

  test "should get edit" do
    get edit_t1topic_url(@t1topic)
    assert_response :success
  end

  test "should update t1topic" do
    patch t1topic_url(@t1topic), params: { t1topic: { order: @t1topic.order, running: @t1topic.running, title: @t1topic.title } }
    assert_redirected_to t1topic_url(@t1topic)
  end

  test "should destroy t1topic" do
    assert_difference('T1topic.count', -1) do
      delete t1topic_url(@t1topic)
    end

    assert_redirected_to t1topics_url
  end
end
