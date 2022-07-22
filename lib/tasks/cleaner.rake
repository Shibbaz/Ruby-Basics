# frozen_string_literal: true

namespace :cleaner do
  desc 'If you want to run rubocop'
  task rubocop: :environment do
    system('rubocop -a')
  end
  task standard: :environment do
    system('bundle exec standardrb --fix')
  end
end
