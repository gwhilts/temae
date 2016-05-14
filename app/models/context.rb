class Context < ActiveRecord::Base
  # Icons
  ICONS = {
    'inbox'    => 'fi-download',
    'github'   => 'fi-social-github',
    'home'     => 'fi-home',
    'office'   => 'fi-torso-business',
    'phone'    => 'fi-telephone',
    'errand'   => 'fi-marker',
    'email'    => 'fi-mail',
    'shopping' => 'fi-shopping-cart',
    'generic'  => 'fi-list-thumbnails'
  }
  
  # Relations
  has_many :tasks
  belongs_to :user

  # Nexted Contexts
  has_many :children, class_name: "Context", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Context"

  # Validations
  validates :name, :user, :icon, presence: true
  validates :icon, inclusion: { in: ICONS.keys, 
                                message: "must be one of: %{ ICONS.keys }." 
                              }

  # Callbacks
  after_initialize :set_defaults 
  before_destroy :check_for_tasks
  
  # Private Methods
  private

  def set_defaults
    self.icon ||= 'generic'
  end

  def check_for_tasks
    if tasks.count > 0
      errors[:base] << "Cannot delete a context that contains open tasks"
      return false
    end
  end

end
