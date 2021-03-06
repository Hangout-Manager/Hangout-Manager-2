class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all.order(start_date: "ASC").first(100)
    render json: @posts
  end

  def index_label_1
    @posts_1 = Post.where(label_id:1).order(start_date: "ASC").first(100)
    render json: @posts_1
  end
  
  def index_label_2
    @posts_2 = Post.where(label_id:2).order(start_date: "ASC").first(100)
    render json: @posts_2
  end

  def index_label_3
    @posts_3 = Post.where(label_id:3).order(start_date: "ASC").first(100)
    render json: @posts_3
  end

  # GET /posts/1
  def show
    @paricipation = Participation.new
    @comments = @post.comments
    # @comment = current_api_user.comments.new
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.permit(:title, :content, :label_id, :user_id, :tag, :upper_number, :start_time, :start_date, :estimate_time)
    end
end
