class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  validates :name,
    uniqueness: true,
    length: { in: 2..20 }
  validates :introduction,
    length: { maximum: 50 }
  has_many :books, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def self.guest
    find_or_create_by(email: "test@test.com") do |user|
      user.name = "guest"
      user.password = SecureRandom.urlsafe_base64
      user.introduction = ""
      user.image_id = ""
    end
  end

  def active_for_authentication?
    super && (self.is_valid == true)
  end
end
