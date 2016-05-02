class Task < ActiveRecord::Base
  belongs_to :context
  belongs_to :user

  validates :name, presence: true
end
