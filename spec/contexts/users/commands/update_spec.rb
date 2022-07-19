# frozen_string_literal: true

require 'rails_helper'
require 'faker'

RSpec.describe Contexts::Users::Commands::Update do
  describe '#call' do
    subject(:command) { described_class.new }

    before { create(:user) }

    let(:first_user) { User.first }
    let(:params) { { id: first_user.id, first_name: 'test' } }

    context 'when valid params' do
      it 'updates user' do
        command.call(params)
        expect(first_user.reload.first_name).to eq('test')
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
