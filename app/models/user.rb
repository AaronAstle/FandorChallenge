class User < ApplicationRecord

  has_secure_password

  has_many :films, foreign_key: :created_by
  has_many :ratings, through: :films, foreign_key: :user_id

  validates_presence_of :name, :email, :password_digest
end
