require "test_helper"

class CardsControllerTest < ActionDispatch::IntegrationTest
  test "should get new:get" do
    get cards_new:get_url
    assert_response :success
  end

  test "should get create:post" do
    get cards_create:post_url
    assert_response :success
  end

  test "should get update:put" do
    get cards_update:put_url
    assert_response :success
  end

  test "should get destory:delete" do
    get cards_destory:delete_url
    assert_response :success
  end
end
