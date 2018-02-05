class PagesController < ApplicationController
  def home
    @categories = Category.all
    @articles = Article.where(status: :approved).page(params[:page]).per(12).order(created_at: :desc)
    @podcasts = Podcast.where(status: :published).page(params[:page]).per(5).order(episode: :desc)
    if params[:slug]
      @category = @categories.find_by(slug: params[:slug])
      @articles = @category.articles.where(status: :approved).page(params[:page]).per(12).order(created_at: :desc)
      @podcasts = Podcast.where(status: :published).page(params[:page]).per(5).order(episode: :desc)
      @slug = @category.slug
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def privacy_policy
  end

end