class Context < ActiveRecord::Base
  # Icons
  ICONS = {
    'github'   => '<i class="fi-social-github"></i>',
    'home'     => '<i class="fi-home"></i>',
    'office'   => '<i class="fi-torso-business"></i>',
    'phone'    => '<i class="fi-telephone"></i>',
    'errand'   => '<i class="fi-marker"></i>',
    'email'    => '<i class="fi-mail"></i>',
    'shopping' => '<i class="fi-shopping-cart"></i>',
    'generic'  => '<i class="fi-list-thumbnails"></i>'
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

end
