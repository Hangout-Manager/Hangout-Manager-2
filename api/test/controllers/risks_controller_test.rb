require 'test_helper'

class RisksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @risk = risks(:one)
  end

  test "should get index" do
    get risks_url, as: :json
    assert_response :success
  end

  test "should create risk" do
    assert_difference('Risk.count') do
      post risks_url, params: { risk: { hangout_id: @risk.hangout_id, value: @risk.value } }, as: :json
    end

    assert_response 201
  end

  test "should show risk" do
    get risk_url(@risk), as: :json
    assert_response :success
  end

  test "should update risk" do
    patch risk_url(@risk), params: { risk: { hangout_id: @risk.hangout_id, value: @risk.value } }, as: :json
    assert_response 200
  end

  test "should destroy risk" do
    assert_difference('Risk.count', -1) do
      delete risk_url(@risk), as: :json
    end

    assert_response 204
  end
end
