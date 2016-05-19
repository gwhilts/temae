class Task < ActiveRecord::Base
  # Related Models
  belongs_to :context
  belongs_to :user
  belongs_to :project

  # Validations
  validates :name, :user, presence: true

  # Callbacks
  before_create :set_defaults


  # Private Methods
  private

  def set_defaults
    self.context  ||= self.user.contexts.where(name: 'Inbox').first
    self.project  ||= self.user.projects.where(name: 'misc').first
    self.start    ||= Time.now
  end
end
