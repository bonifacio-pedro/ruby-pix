# frozen_string_literal: true

require_relative 'config'
require_relative 'lib/actions'
require_relative 'db/database'

Actions.start_system

begin
  case ARGV[0]
  when '--new'
    Actions.new_pix({ username: ARGV[1], key_type: ARGV[2], key: ARGV[3] })
  when '--transaction'
    Actions.new_transaction({ payer: ARGV[1], receiver: ARGV[2], price: ARGV[3] })
  when '--transactions'
    Actions.transactions
  when '--search'
    Actions.search({ key: ARGV[1] })
  when '--help'
    puts Config::HELPER
  when '--db'
    Database::Configure.create_tables
    puts 'The tables were created successfully'
  else
    puts Config::HELPER
  end
rescue Sequel::DatabaseError
  puts '[!] Please run: ruby app.rb --db'
end
