class Project < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: :user_id
  has_many :assignments, dependent: :destroy
  has_many :members, through: :assignments, source: :user
  has_many :comments, -> { order(updated_at: :desc) }, dependent: :destroy

  enum :status, {
    :pending => "Pending", 
    :active => "Active", 
    :archived => "Archived" 
  }

  # TODO: filter available status base on current status
  def available_status
    Project.statuses
  end
end
