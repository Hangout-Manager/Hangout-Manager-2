require 'test_helper'

class CovidQuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @covid_question = covid_questions(:one)
  end

  test "should get index" do
    get covid_questions_url, as: :json
    assert_response :success
  end

  test "should create covid_question" do
    assert_difference('CovidQuestion.count') do
      post covid_questions_url, params: { covid_question: { name: @covid_question.name, q1: @covid_question.q1, q2: @covid_question.q2, q3: @covid_question.q3 } }, as: :json
    end

    assert_response 201
  end

  test "should show covid_question" do
    get covid_question_url(@covid_question), as: :json
    assert_response :success
  end

  test "should update covid_question" do
    patch covid_question_url(@covid_question), params: { covid_question: { name: @covid_question.name, q1: @covid_question.q1, q2: @covid_question.q2, q3: @covid_question.q3 } }, as: :json
    assert_response 200
  end

  test "should destroy covid_question" do
    assert_difference('CovidQuestion.count', -1) do
      delete covid_question_url(@covid_question), as: :json
    end

    assert_response 204
  end
end
