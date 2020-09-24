class LongTrendsController < ApplicationController
  before_action :set_long_trend, only: [:show, :update, :destroy]

  # GET /long_trends
  def index
    @long_trends = LongTrend.all

    render json: @long_trends
  end

  def index_without_me
    @long_trends_without_me = LongTrend.all.where.not(user_id: params[:user_id])
    render json: @long_trends_without_me
  end

  # GET /long_trends/1
  def show
    render json: @long_trend
  end

  # POST /long_trends
  def create
    @long_trend = LongTrend.new(long_trend_params)

    if @long_trend.save
      render json: @long_trend, status: :created, location: @long_trend
    else
      render json: @long_trend.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /long_trends/1
  def update
    if @long_trend.update(long_trend_params)
      render json: @long_trend
    else
      render json: @long_trend.errors, status: :unprocessable_entity
    end
  end

  # DELETE /long_trends/1
  def destroy
    @long_trend.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_long_trend
      @long_trend = LongTrend.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def long_trend_params
      params.permit(:agon, :alea, :mimicry, :ilinx, :user_id)
    end
end
