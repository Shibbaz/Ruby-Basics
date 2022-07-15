require 'rails_helper'
require 'faker'

RSpec.describe Contexts::Users::Commands::Update do
  describe '#call' do
    subject(:command) { described_class.new }

    before { create(:user) }

    let(:first_user) { User.first }
    let(:params) do
      {
        id: first_user.id,
        first_name: Faker::Name.name,
        last_name: Faker::Name.name,
        email: first_user.email,
        role: 'Software Engineer'
      }
    end

    context 'when valid params' do
      it 'updates user' do
        old_year = params[:year]
        params[:first_name] = 1998
        command.call(params)
        new_year = User.first.first_name
        expect(new_year).not_to eq(old_year)
      end
    end

    context 'when not valid params' do
      it 'does not update user' do
        params[:id] = 100

        expect { command.call(params) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
