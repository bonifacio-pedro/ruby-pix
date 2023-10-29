# frozen_string_literal: true

require_relative 'config'
require_relative 'lib/pix'
require_relative 'lib/transaction'
require_relative 'db/database'
require 'tty-spinner'
require 'tty-table'

system('clear')
spinner = TTY::Spinner.new('[:spinner] Loading system...', format: :pulse)
spinner.auto_spin
sleep(2)
spinner.stop('Ready!')
sleep(1)
system('clear')

begin
  case ARGV[0]
  when '--new'
    # username key_type key
    if !ARGV[1].nil? && !ARGV[2].nil? && Config::PIX_TYPES.include?(ARGV[2])
      if !ARGV[3].nil?
        sleep(0.5)
        puts Pix.insert_data_new_pix(ARGV[1], ARGV[2], ARGV[3])
      else
        puts 'Add a valid key'
      end
    else
      puts 'Enter a valid pix key type!
      VALID TYPES:
          - CPF
          - CELL
          - EMAIL'
    end
  when '--transaction'
    if !ARGV[1].nil? && !ARGV[2].nil? && !ARGV[3].nil? && !ARGV[3].include?(',')
      sleep(1)
      Transaction.new(ARGV[1], ARGV[2], ARGV[3].to_f)
    else
      puts "Add keys and a valid price for the transaction! example:\n
      ruby app.rb -t [VALID KEY] [VALID KEY] 10.99"
    end
  when '--transactions'
    table = TTY::Table.new(
      header: %w[Id Payer Receiver Price Datetime]
    )
    transactions = Database::Query.return_all_transactions
    transactions.each do |t|
      t[:transaction_date] = t[:transaction_date].inspect.to_s[0..9]
      table << t
    end
    puts table.render(:unicode)
  when '--search'
    if !ARGV[1].nil?
      puts Pix.search_key_initial(ARGV[1])
    else
      puts 'Enter a valid search parameter'
    end
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
