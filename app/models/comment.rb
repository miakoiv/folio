class Comment < ApplicationRecord

  include Trackable

  belongs_to :post
  belongs_to :author, -> { merge(User.including_deleted) }, class_name: 'User'

  default_scope { order(created_at: :asc) }
  scope :by, -> (author) { where(author: author) }

  validates :content, presence: true

  def to_s
    content
  end
end
