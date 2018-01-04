module PagesHelper
  def show_podcast
    unless @slug
      render('podcasts')
    end
  end
end