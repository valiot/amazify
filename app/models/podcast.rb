class Podcast < ApplicationRecord
  belongs_to :category
  belongs_to :user
  enum status: [:draft, :published, :rejected]
  enum tags: [:begginer, :intermediate, :advanced]
  validates :episode, uniqueness: true, presence: true
  validates :category_id, presence: true
  validates :tags, presence: true
  validate :check_protocol

  private

  def check_protocol
    return if video_link.starts_with? 'https'
    errors.add :HTTPS_Protocol, 'Check that the video link have "https" instead of "http"'
    false
    return if audio_link.starts_with? 'https'
    errors.add :HTTPS_Protocol, 'Check that the audio link have "https" instead of "http"'
    false
  end
end
