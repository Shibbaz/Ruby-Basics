require 'rails_helper'
require 'faker'

RSpec.describe Contexts::Users::Commands::Create do
  describe '#call' do
    subject(:command) do
      described_class.new
    end

    before { create(:user) }

    let(:params) do
      {
        first_name: Faker::Name.name,
        last_name: Faker::Name.name,
        email: Faker::Internet.email,
        role: 'Software Engineer',
        password_digest: Faker::Internet.password
      }
    end

    context 'when valid params' do
      it 'creates record' do
        user = command.call(params:)
        expect(User.exists?(first_name: user.first_name)).to eq(true)
      end
    end
  end
end
