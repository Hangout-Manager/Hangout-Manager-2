require 'test_helper'

class LongTrendsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @long_trend = long_trends(:one)
  end

  test "should get index" do
    get long_trends_url, as: :json
    assert_response :success
  end

  test "should create long_trend" do
    assert_difference('LongTrend.count') do
      post long_trends_url, params: { long_trend: { agon: @long_trend.agon, alea: @long_trend.alea, ilinx: @long_trend.ilinx, mimicry: @long_trend.mimicry, user_id: @long_trend.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show long_trend" do
    get long_trend_url(@long_trend), as: :json
    assert_response :success
  end

  test "should update long_trend" do
    patch long_trend_url(@long_trend), params: { long_trend: { agon: @long_trend.agon, alea: @long_trend.alea, ilinx: @long_trend.ilinx, mimicry: @long_trend.mimicry, user_id: @long_trend.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy long_trend" do
    assert_difference('LongTrend.count', -1) do
      delete long_trend_url(@long_trend), as: :json
    end

    assert_response 204
  end
end
