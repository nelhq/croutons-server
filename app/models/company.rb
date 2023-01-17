class Company < ApplicationRecord
  validates :name, presence: true

  has_many :brands, dependent: :destroy
end
