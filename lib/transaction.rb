# frozen_string_literal: true

require_relative 'pix'
require_relative '../db/database'
require_relative '../config'
require 'tty-table'

# Initialize, table and all transactions
class Transaction
  include Config
  include Database
  attr_reader :payer, :receiver, :price, :date

  def initialize(payer_key, receiver_key, price)
    @payer = payer_key
    @receiver = receiver_key
    @price = price
    @date = Time.new

    # If key exists
    if verify_keys
      Query.insert_new_transaction(@payer, @receiver, @price, @date)
      puts 'Transaction added successfully, run ruby ​​app.rb --transactions to check'
    else
      puts 'Keys not found'
    end
  end

  def verify_keys
    return false if Query.search_pix(@payer).zero? || Query.search_pix(@receiver).zero?

    true
  end
end
