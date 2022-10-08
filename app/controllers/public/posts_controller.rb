class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]

  def index
    @posts = Post.active_posts
    @posts = @posts.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?
    @posts = @posts.where(tag_id: params[:tag_id]) if params[:tag_id].present?
    @posts = @posts.page(params[:page])
    
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.page(params[:page]).per(7).reverse_order
  end

end
