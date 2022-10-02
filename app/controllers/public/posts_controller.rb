class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]

  def index
    @posts_true = Post.where(is_active: true).order('id DESC').page(params[:page])
    @posts_true_count = Post.where(is_active: true).count
    @posts = Post.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.page(params[:page]).per(7).reverse_order
  end

end
