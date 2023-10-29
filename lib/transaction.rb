require_relative 'pix'
require_relative '../config'
require 'tty-table'

# Initialize, table and all transactions
class Transaction
  include Config
  attr_accessor :payer, :receiver, :price, :date

  def initialize(payer_key, receiver_key, price)
    @payer = payer_key
    @receiver = receiver_key
    @date = Time.new
    @price = price

    # If key exists
    if verify_keys
      DB.execute 'INSERT INTO Transactions VALUES (?, ?, ?, ?)', [@payer, @receiver, @date.inspect.to_s, price.to_f]
      puts transaction_table
    else
      puts 'Keys not found'
    end
  end

  def transaction_table
    table = TTY::Table.new(
      header: %w[Payer Receiver Price Datetime],
      rows: [[@payer, @receiver, @price, @date.inspect.to_s[0..15]]]
    )
    table.render(:unicode)
  end

  def verify_keys
    false if Pix.search_pix(@payer).empty? || Pix.search_pix(@receiver).empty?
    true
  end

  def self.return_all_transactions
    DB.execute 'SELECT * FROM Transactions'
  end
end
