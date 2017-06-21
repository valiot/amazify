class PagesController < ApplicationController
  def home
    @articles = Article.all.page(params[:page]).per(12)
    @categories = Category.all

    respond_to do |format|
      format.html
      format.js
    end
  end
end
