require 'rails_helper'

RSpec.describe Task, type: :model do 
  let(:task) { Task.new }

  context "validations" do
    before(:each) do
      @t = task
      @t.valid?
    end
    it "validates presence of associated user"  do
      expect(@t.errors).to have_key(:user)
    end    
    it "validates presence of name" do
      expect(@t.errors).to have_key(:name)
    end
    it "validates presence of context" do
      expect(@t.errors).to have_key(:context)
    end
  end

  describe "#new" do
    let(:task) { Task.new }

    context "with no context provided" do
      it "assigns task context to 'inbox'"
    end

    context "with no start date provided" do
      it "assigns start to today's date"
    end
  end

  
end
