class Brand < ApplicationRecord
  belongs_to :company

  has_many :products, dependent: :destroy
  validates :name, presence: true
end
