class PagesController < ApplicationController
  def home
    @articles = Article.all.page(params[:page]).per(12)
    if params[:category_id]
      @articles = Article.where(category_id: params[:category_id]).page(params[:page]).per(12)
    end
    @categories = Category.all

    respond_to do |format|
      format.html
      format.js
    end
  end




end
