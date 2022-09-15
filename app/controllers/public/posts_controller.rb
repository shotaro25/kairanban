class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]

  def index
    @posts_true = Post.where(is_active: true).order('id DESC').page(params[:page])
    @posts_true_count = Post.where(is_active: true).count
  end

  def show
    @post = Post.find(params[:id])
  end

end
