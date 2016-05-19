require 'rails_helper'

RSpec.describe User, type: :model do 
  let(:user) { User.create!(email: 'j@p.com', password: 'secret', password_confirmation: 'secret') }

  describe '#create' do
    it 'assigns the default contexts' do
      expect(user.contexts.count).to eq(6)
    end
  end

  describe '#destroy' do
    it "also destroys the user's tasks" do
      u = user
      Task.new(name: 'foo', user: u).save!
      expect(Task.where(user_id: u.id).count).to eq(1)
      u.destroy!
      expect(Task.where(user_id: u.id).count).to eq(0)
    end

    it "also destroys the user's contexts" do
      u = user
      Context.new(name: 'bar', user: u).save!
      expect(Context.where(user_id: u.id).count).to be > (0)
      u.destroy!
      expect(Context.where(user_id: u.id).count).to eq(0)
    end
    
    it "also destroys the user's projects" do
      u = user
      Project.new(name: 'baz', user: u).save!
      expect(Project.where(user_id: u.id).count).to be > (0)
      u.destroy!
      expect(Project.where(user_id: u.id).count).to eq(0)
    end 
  end
end
