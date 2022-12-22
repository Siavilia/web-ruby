# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :questions, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :email, presence: true, uniqueness: true, 'valid_email_2/email': true
  validates :name, presence: true, length: { minimum: 2 }

  def author?(obj)
    obj.user == self
  end
end
