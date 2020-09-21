require 'test_helper'

class HangoutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hangout = hangouts(:one)
  end

  test "should get index" do
    get hangouts_url, as: :json
    assert_response :success
  end

  test "should create hangout" do
    assert_difference('Hangout.count') do
      post hangouts_url, params: { hangout: { agon: @hangout.agon, alea: @hangout.alea, ilinx: @hangout.ilinx, mimicry: @hangout.mimicry, name: @hangout.name } }, as: :json
    end

    assert_response 201
  end

  test "should show hangout" do
    get hangout_url(@hangout), as: :json
    assert_response :success
  end

  test "should update hangout" do
    patch hangout_url(@hangout), params: { hangout: { agon: @hangout.agon, alea: @hangout.alea, ilinx: @hangout.ilinx, mimicry: @hangout.mimicry, name: @hangout.name } }, as: :json
    assert_response 200
  end

  test "should destroy hangout" do
    assert_difference('Hangout.count', -1) do
      delete hangout_url(@hangout), as: :json
    end

    assert_response 204
  end
end
