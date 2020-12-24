class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  with_options presence: true do
   validates :nickname, :birth_day
   validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'Include both letters and numbers'}
   validates :family_name, :first_name,format:{ with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'Full-width characters' } 
   validates :family_name_kana, :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'Full-width katakana characters' } 
  end
  
end