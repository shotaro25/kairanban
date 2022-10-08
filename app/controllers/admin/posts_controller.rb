class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to admin_post_path(@post.id)
    else
      @post = Post.new
      render 'new'
    end
  end

  def index
    @posts = Post.all
    @posts = @posts.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?
    @posts = @posts.where(tag_id: params[:tag_id]) if params[:tag_id].present?
    @posts = @posts.page(params[:page])

    # @posts = Post.all.order('id DESC').page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.page(params[:page])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post =Post.find(params[:id])
    @post.update(post_params)
    redirect_to admin_post_path(@post.id)
  end

  private

  def post_params
    params.require(:post).permit(:image, :name, :introduction, :is_active, :tag_id)
  end

end
