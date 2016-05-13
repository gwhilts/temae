class Task < ActiveRecord::Base
  belongs_to :context
  belongs_to :user

  validates :name, :user, :context, presence: true

  def project_name
    # stubbing out with canned answer
    # TODO: Replace with call to associated Project model (once it exists)
    "miscellaneous"
  end

  def context_name
    context ? context.name : "Inbox"
  end
end
