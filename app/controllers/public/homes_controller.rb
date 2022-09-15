class Public::HomesController < ApplicationController

  def top
    @posts_true_top = Post.where(is_active: true).order('id DESC').limit(4)
  end
end