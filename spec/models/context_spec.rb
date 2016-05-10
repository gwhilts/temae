require 'rails_helper'

RSpec.describe Context, type: :model do 
  describe '#new' do
    let(:context) { Context.new }
    context 'when no icon is specified' do
      it 'assigns the generic icon' do
        expect(context.icon).to eq('generic')
      end
    end
  end
end
