require 'rails_helper'
require 'faker'

RSpec.describe Contexts::Users::Commands::Delete do
  describe '#call' do
    subject(:command) { described_class.new }

    before { create_list(:user, 2) }

    context 'when valid params' do
      it 'deletes user' do
        user = User.first
        user_name = user.first_name
        command.call(user.id)
        expect(User.exists?(first_name: user_name)).to eq(false)
      end
    end

    context 'when not valid params' do
      it 'does not delete an user' do
        expect { command.call(100) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
