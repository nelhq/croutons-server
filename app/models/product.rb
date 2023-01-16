class Product < ApplicationRecord
  belongs_to :brand

  validates :name, presence: true
  has_many_attached :images

  has_many :reference_tiktok_movies, dependent: :destroy

  def image_urls
    images.map do |image|
      Rails.application.routes.url_helpers.rails_storage_proxy_url(image)
    end
  end

  def primary_image_url
    images&.first
  end
end
