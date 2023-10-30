# frozen_string_literal: true

require_relative '../config'
require_relative '../db/database'
require_relative 'pix'
require_relative 'transaction'
require 'tty-spinner'
require 'tty-table'

# App actions
module Actions
  include Config
  include Database

  # Insert new pix
  def self.new_pix(args)
    if verify_args?(args) && PIX_TYPES.include?(args[:key_type])
      sleep(0.5)
      puts Pix.insert_data_new_pix(args[:username], args[:key_type], args[:key])
    else
      puts 'Enter a valid pix key and key type (verify if your key is correct)!
      VALID TYPES:
          - CPF
          - CELL
          - EMAIL'
    end
  end

  # Search key
  def self.search(args)
    return puts Pix.search_key_initial(args[:key]) if verify_args?(args)

    puts 'Enter a valid search parameter' 
  end

  # Insert new transaction
  def self.new_transaction(args)
    if self.verify_args?(args)
      sleep(0.5)
      Transaction.new(args[:payer], args[:receiver], args[:price])
    else
      puts "Add keys and a valid price for the transaction! example:\n
      ruby app.rb -t [VALID KEY] [VALID KEY] 10.99"
    end
  end

  # Show all transactions
  def self.transactions
    transactions = Query.return_all_transactions
    puts generate_table(%w[Id Payer Receiver Price Datetime], transactions)
  end

  # Generates a table
  def self.generate_table(headers, items)
    table = TTY::Table.new(
      header: headers
    )
    items.map { |i| table << i }
    table.render(:unicode)
  end

  # Start app
  def self.start_system
    system('clear')
    spinner = TTY::Spinner.new('[:spinner] Loading system...', format: :pulse)
    spinner.auto_spin
    sleep(2)
    spinner.stop('Ready!')
    sleep(1)
    system('clear')
  end

  # Verify system args
  def self.verify_args?(args)
    args.each_value do |arg|
      return false if arg.nil?
    end
    true
  end
end
