class Context < ActiveRecord::Base
  # Relations
  has_many :tasks
  belongs_to :user

  # Nexted Contexts
  has_many :children, class_name: "Context", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Context"
end
