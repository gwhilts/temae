require 'rails_helper'

RSpec.describe Task, type: :model do 
# let(:task) { Task.new }
  let(:user) { create(:user) }
  let(:valid_attrs) {
    { name: 'fubar',
      user: user
    }
  }

  context "validations" do
    before(:each) do
      @t = Task.new
      @t.valid?
    end
    it "validates presence of associated user"  do
      expect(@t.errors).to have_key(:user)
    end    
    it "validates presence of name" do
      expect(@t.errors).to have_key(:name)
    end
  end

  describe "#before_create" do
    before(:each) do
      @t = Task.new
      @t.update(valid_attrs)
    end

    context "with no context provided" do
      it "assigns task context to 'Inbox'" do
        expect(@t.context.name).to eq('Inbox')
      end
    end

    context "with no start date provided" do
      it "assigns start to today's date" do
        expect(@t.start.to_s).to eq(Time.now.strftime("%F"))
      end
    end

    context 'with no project specified' do
      it "assigns the task to the user's 'misc' project" do
        expect(@t.project.name).to eq('misc')
      end
    end
  end

  describe "#available" do
    before(:each) do
      @t = Task.create!(valid_attrs)
    end
    context "when start date is more than one day in the future" do
      it "returns 'unavailable'" do
        @t.update(start: (Time.now + 2.days))
        expect(@t.available).to eq('unavailable')
      end
    end
    context "when start date is not more than one day in the future" do
      it "returns 'available'" do
        @t.update(start: Time.now)
        expect(@t.available).to eq('available')
        @t.update(start: (Time.now - 2.days))
        expect(@t.available).to eq('available')
        @t.update(start: (Time.now + 1.day))
        expect(@t.available).to eq('available')
      end
    end
    # TODO
#   context "when its project is sequential" do
#     context "and the task is the 'next action'" do
#       it "returns 'available'"
#     end
#     context "and the task is not the 'next action'" do
#       it "returns 'unavailable'"
#     end
#   end
#   context "when its project is not sequential" do
#     it "returns 'available'"
#   end
  end
end
