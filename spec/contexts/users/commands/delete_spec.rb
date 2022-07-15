require 'rails_helper'
require 'faker'

RSpec.describe Contexts::Users::Commands::Delete do
  describe '#call' do
    subject(:command) do
      described_class.new
    end

    before do
      create_list(:user, 2)
    end

    context 'when valid params' do
      it 'deletes user' do
        id = User.first.id
        old_size = User.all.size
        command.call(id)
        new_size = User.all.size
        expect(new_size).to eq(old_size - 1)
      end
    end

    context 'when not valid params' do
      it 'does not delete an user' do
        expect { command.call(100) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
