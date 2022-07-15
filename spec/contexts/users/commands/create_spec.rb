require 'rails_helper'
require 'faker'

RSpec.describe Contexts::Users::Commands::Create do
  describe '#call' do
    subject(:command) do
      described_class.new
    end

    before do
      create(:user)
    end

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
        command.call(params:)
      end
    end
  end
end
