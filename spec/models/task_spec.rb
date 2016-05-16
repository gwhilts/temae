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
  end
end
