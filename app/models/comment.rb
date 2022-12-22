# frozen_string_literal: true

class Comment < ApplicationRecord
  include Authorship
  belongs_to :question
  belongs_to :user

  validates :body, presence: true, length: { minimum: 1 }

  def formatted_created_at
    created_at.strftime('%Y-%m-%d %H:%M:%S')
  end
end
