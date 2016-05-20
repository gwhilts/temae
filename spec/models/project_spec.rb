require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user) { create(:user) }
  
  describe '#destory' do
    before(:each) do
      @user = user
      @misc = Project.find_or_create_by!(name: 'misc', user: @user)
      @other_project = Project.create!(name: 'Project2', user: @user, sequential: true)
      @task = Task.create!(name: 'Do it', user: @user, project: @misc)
    end

    it "reassigns its tasks to the user's 'misc' Project" do
      @task.update(project: @other_project)
      expect(@task.project).to eq(@other_project)
      @other_project.destroy
      @task.reload
      expect(@task.project).to eq(@misc)
    end
  end
end
