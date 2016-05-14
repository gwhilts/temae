class Task < ActiveRecord::Base
  # Related Models
  belongs_to :context
  belongs_to :user

  # Validations
  validates :name, :user, presence: true

  # Callbacks
  before_create :set_defaults


  # Public Methods
  def project_name
    # stubbing out with canned answer
    # TODO: Replace with call to associated Project model (once it exists)
    "miscellaneous"
  end

  # Private Methods
  private

  def set_defaults
    self.context ||= self.user.contexts.where(name: 'Inbox').first
    self.start   ||= Time.now
  end
end
