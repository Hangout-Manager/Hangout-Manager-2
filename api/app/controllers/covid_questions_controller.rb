class CovidQuestionsController < ApplicationController
  before_action :set_covid_question, only: [:show, :update, :destroy]

  # GET /covid_questions
  def index
    @covid_questions = CovidQuestion.all

    render json: @covid_questions
  end

  # GET /covid_questions/1
  def show
    render json: @covid_question
  end

  # POST /covid_questions
  def create
    @covid_question = CovidQuestion.new(covid_question_params)

    if @covid_question.save
      render json: @covid_question, status: :created, location: @covid_question
    else
      render json: @covid_question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /covid_questions/1
  def update
    if @covid_question.update(covid_question_params)
      render json: @covid_question
    else
      render json: @covid_question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /covid_questions/1
  def destroy
    @covid_question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_covid_question
      @covid_question = CovidQuestion.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def covid_question_params
      params.permit(:name, :q1, :q2, :q3)
    end
end
