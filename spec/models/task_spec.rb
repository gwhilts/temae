require 'rails_helper'

RSpec.describe Task, type: :model do 
  describe "#new" do
    context "with no context provided" do
      it "assigns task context to 'inbox'"
    end
    context "with no start date provided" do
      it "assigns start to today's date"
    end
  end
end
