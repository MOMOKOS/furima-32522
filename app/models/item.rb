class Item < ApplicationRecord
  belongs_to :user
  has_one :orderhistory
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :cost
  belongs_to :prefecture
  belongs_to :day

  with_options presence: true do
    validates :image, :name, :description
    validates :price, numericality: { with: /\d[0-9]/, message: 'Half-width number' }
  end

  validates :price,
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'Out of setting range' }

  with_options numericality: { other_than: 1, message: 'Select' } do
    validates :category_id, :status_id, :cost_id, :prefecture_id, :day_id
  end
end
