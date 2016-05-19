class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # Relations
  has_many :tasks, dependent: :destroy
  has_many :contexts, dependent: :destroy
  has_many :projects, dependent: :destroy

  # Callbacks
  after_create :create_default_contexts
  after_create :create_default_projects

  private

  def create_default_contexts
    [
      { name: 'Inbox',   user: self, icon: 'inbox' },
      { name: 'Email',   user: self, icon: 'email' },
      { name: 'Errands', user: self, icon: 'errands' },
      { name: 'Home',    user: self, icon: 'home' },
      { name: 'Phone',   user: self, icon: 'phone' },
      { name: 'Office',  user: self, icon: 'office' },
    ].each do |context|
      Context.create! context
    end
  end

  def create_default_projects
    [
      { name: 'misc', user: self, sequential: false }
    ].each do |project|
      Project.create! project
    end
  end

end
