class Project < ActiveRecord::Base
  # Relations
  belongs_to :user
  has_many :tasks

  # Validations
  validates :user, presence: true
end
