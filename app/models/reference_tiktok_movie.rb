class ReferenceTiktokMovie < ApplicationRecord
  belongs_to :product

  validates :embed_url, presence: true
end
