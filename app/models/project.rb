class Project < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  has_many :assignments, dependent: :destroy
  has_many :members, through: :assignments, source: :user
  has_many :comments, dependent: :destroy
end
