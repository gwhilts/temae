class Context < ActiveRecord::Base
  # Icons
  ICONS = {
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

  after_initialize :set_defaults 
  
  def set_defaults
    self.icon ||= 'generic'
  end

end
