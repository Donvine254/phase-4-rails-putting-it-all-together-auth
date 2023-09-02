class User < ApplicationRecord
    has_secure_password
    validates :password, presence: true, confirmation: true
    validates :username, presence: true, uniqueness: {case_sensitive: false}
    validates_presence_of :bio, :image_url
    has_many :recipes, dependent: :destroy
end
