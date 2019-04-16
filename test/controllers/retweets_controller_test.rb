require 'test_helper'

class RetweetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @retweet = retweets(:one)
  end

  test "should get index" do
    get retweets_url, as: :json
    assert_response :success
  end

  test "should create retweet" do
    assert_difference('Retweet.count') do
      post retweets_url, params: { retweet: { id: @retweet.id, references: @retweet.references } }, as: :json
    end

    assert_response 201
  end

  test "should show retweet" do
    get retweet_url(@retweet), as: :json
    assert_response :success
  end

  test "should update retweet" do
    patch retweet_url(@retweet), params: { retweet: { id: @retweet.id, references: @retweet.references } }, as: :json
    assert_response 200
  end

  test "should destroy retweet" do
    assert_difference('Retweet.count', -1) do
      delete retweet_url(@retweet), as: :json
    end

    assert_response 204
  end
end
