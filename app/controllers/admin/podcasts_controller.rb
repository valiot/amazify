class Admin::PodcastsController < Admin::ApplicationController
  before_action :set_podcast, only: [:show, :edit, :update, :destroy, :approve, :reject]

  def index
    @podcasts = Podcast.all
  end

  def approve
    authorize @podcast
    respond_to do |format|
      if @podcast.update(status: :published)
        flash.now[:notice] = 'The podcast was successfully published.'
        format.js
      else
        format.html { render :edit }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  def reject
    authorize @podcast
    respond_to do |format|
      if @podcast.update(status: :rejected)
        flash.now[:alert] = 'The podcast was successfully rejected.'
        format.js
      else
        format.html { render :edit }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def new
    @podcast = Podcast.new
  end

  def edit
  end

  def create
    @podcast = Podcast.new(podcast_params)
    authorize @podcast
    @podcast.user = current_user
    @podcast.video_link.gsub!(/(\&|)utm([_a-z0-9=]+)/, '')
    @podcast.audio_link.gsub!(/(\&|)utm([_a-z0-9=]+)/, '')
    @podcast.image = upload_to_s3(params[:podcast][:image])
    @podcast.thumbnail = upload_to_s3(params[:podcast][:thumbnail])
    @podcast.slug = @podcast.title.parameterize
    if @podcast.save
      redirect_to [:admin, @podcast], notice: 'Podcast was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @podcast
    @podcast_update = podcast_params
    if params[:podcast][:image]
      @podcast_update[:image] = upload_to_s3(params[:podcast][:image])
    end
    if params[:podcast][:thumbnail]
      @podcast_update[:thumbnail] = upload_to_s3(params[:podcast][:thumbnail])
    end
    @podcast.slug = params[:podcast][:title].parameterize
    if @podcast.update(@podcast_update)
      redirect_to [:admin, @podcast], notice: 'Podcast was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @podcast
    @podcast.destroy
    redirect_to podcasts_url, notice: 'Podcast was successfully destroyed.'
  end

  private

  def upload_to_s3(file)
    filename = file.original_filename.downcase.tr!(" ", "_")
    extension = file.original_filename[-3..-1]
    service = S3::Service.new(access_key_id: ENV['AWS_KEY'],
                              use_ssl:true,
                              secret_access_key: ENV['AWS_SECRET'])

    bucket = service.buckets.find(ENV['S3_BUCKET'])
    new_object = bucket.objects.build("amazify/#{filename}-#{SecureRandom.hex}.#{extension}")
    new_object.content = open(file.tempfile)
    return new_object.url if new_object.save
    false
  end

  def set_podcast
    @podcast = Podcast.find(params[:id])
  end

  def podcast_params
    params.require(:podcast).permit(:episode, :video_link, :audio_link, :image, :text, :thumbnail, :published, :title, :guests, :quote, :category_id, :tags)
  end
end