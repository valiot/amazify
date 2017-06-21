class PagesController < ApplicationController
  def home
    @categories = Category.all
    @articles = Article.all.page(params[:page]).per(2)
    if params[:category]
      @articles = @categories.find_by(name: params[:category]).articles.page(params[:page]).per(2)
    end
    @categories = Category.all

    respond_to do |format|
      format.html
      format.js
    end
  end




end
