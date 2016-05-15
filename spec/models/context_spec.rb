require 'rails_helper'

RSpec.describe Context, type: :model do 

  let(:context) { Context.new }
  let(:user) { create(:user) }
  let(:valid_attrs) {
    { user: user, name: 'Office', icon: 'office' }
  }

  describe 'validations' do
    before(:each) do
      @c = context
      @c.user, @c.name, @c.icon = nil
      @c.valid?
    end

    it "validates presence of user" do
      expect(@c.errors).to have_key(:user)
    end

    it "validates presence of name" do
      expect(@c.errors).to have_key(:name)
    end

    it "validates presence of icon" do
      expect(@c.errors).to have_key(:icon)
    end
  end

  describe '::new' do
    context 'when no icon is specified' do
      it 'assigns the generic icon' do
        expect(context.icon).to eq('generic')
      end
    end
  end

  describe '::menu_for(user)' do
    it "returns an Hash of :id :name pairs for each of the user's contexts" do
      u = user;
      # User creation will also create default
      # Contexts "Inbox", "Email", "Errands", "Home",
      # and "Office"
      errands = u.contexts.where(name: 'Errands').first
      Context.create(name: 'Foo', user: u)
      Context.create(name: 'Bar', user: u, parent: errands)
      expect(Context.menu_for(u).values).to eq(["Inbox", "Bar", "Email", "Errands", "Foo", "Home", "Office", "Phone"])
    end
  end

  describe '#destroy' do
    before(:each) do
      @c = context
      @c.update(valid_attrs)
      Task.create(user: user, name: 'fubar', context: @c)
      @c.destroy
    end

    it "won't delete a Context with Tasks" do
      expect(@c.errors[:base]).to eq(["Cannot delete a context that contains open tasks"])
      expect(@c.persisted?).to be(true)
    end
  end
end
