class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates_length_of :content, in: 10..50
end
