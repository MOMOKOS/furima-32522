class OrderDestination
  include ActiveModel::Model
  
  attr_accessor :post_code, :prefecture_id, :city, :address, :building_name, :phone_number, :user_id, :item_id, :token
  
  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'Input correctly' }
    validates :city, format: { with: /\A[ぁ-んァ-ン一-龥]/}
    validates :address
    validates :phone_number, numericality: { with: /\A\d{11}\z/, message: ' Input only number' }, length: { maximum: 11}
    validates :token
  end
  validates :prefecture_id, numericality: { other_than: 1, message: 'Select' }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Destination.create(post_code: post_code,  prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end