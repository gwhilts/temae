class Project < ActiveRecord::Base
  # Relations
  belongs_to :user
  has_many :tasks

  # Validations
  validates :user, presence: true


  # Callbacks
  before_destroy :reassign_tasks

  private

  # Reassigns tasks to 'misc' project
  # TODO: replace loop w/ single SQL call
  def reassign_tasks
    if self.tasks.count > 0
      misc = Project.where(name: 'misc', user: user).first
      self.tasks.each { |t| t.update!(project: misc) }
      return true
    end
  end
  
end
