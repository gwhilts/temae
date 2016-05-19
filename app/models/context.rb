class Context < ActiveRecord::Base
  # Icons
  ICONS = {
    'inbox'    => 'fi-download',
    'github'   => 'fi-social-github',
    'home'     => 'fi-home',
    'office'   => 'fi-torso-business',
    'phone'    => 'fi-telephone',
    'errands'   => 'fi-marker',
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
  validates :icon, inclusion: { in: ICONS.keys, message: "must be one of: #{ ICONS.keys }." }

  # Callbacks
  after_initialize :set_defaults 
  before_destroy :check_for_tasks
  
  # Class Methods
  def self.menu_for(user_id)
    inbox    = Context.where(user_id: user_id, name: "Inbox").pluck(:id, :name).to_h
    others   = Context.where(user_id: user_id).where.not(name: 'Inbox').order(:name)
    menu     = (others.collect { |c| {c.id => c.name} }).inject { | m = {}, c | m.merge c }
    inbox.merge menu
  end

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
