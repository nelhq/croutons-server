class Product < ApplicationRecord
  belongs_to :brand

  validates :name, presence: true
  has_many_attached :images

  def image_urls
    images.map do |image|
      Rails.application.routes.url_helpers.rails_storage_proxy_url(image)
    end
  end
end
