class Admin::ArticlesController < Admin::ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :approve, :reject]

  def index
    @articles = Article.where(status: 0)
  end

  def approved
    @articles = Article.where(status: 1)
  end

  def approve
    authorize @article
    respond_to do |format|
      if @article.update(status: :approved)
        flash.now[:notice] = 'Article was successfully approved.'
        format.js
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def reject
    authorize @article
    respond_to do |format|
      if @article.update(status: :rejected)
        flash.now[:alert] = 'Article was successfully rejected.'
        format.js
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    authorize @article
    @article.user = current_user
    @article.link.gsub!(/(\&|)utm([_a-z0-9=]+)/, '')
    if @article.save
      redirect_to [:admin, @article], notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @article
    if @article.update(article_params)
      redirect_to [:admin, @article], notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @article
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:link, :approved, :category_id)
  end
end
