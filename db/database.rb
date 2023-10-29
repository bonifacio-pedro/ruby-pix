# frozen_string_literal: true

require 'sequel'

# Database configure and querys
module Database
  DB = Sequel.connect('sqlite://app.db')

  # All DB Querys to run app
  class Query
    # Insert methods
    def self.insert_new_pix(username, key_type, key)
      DB[:pix].insert(
        username: username,
        key_type: key_type,
        key: key
      )
    end

    def self.insert_new_transaction(payer, receiver, transaction_price, transaction_date)
      DB[:transactions].insert(
        payer: search_username_with_key(payer),
        receiver: search_username_with_key(receiver),
        transaction_price: transaction_price,
        transaction_date: transaction_date
      )
    end

    # Search and return methods
    def self.return_all_transactions
      DB[:transactions].all
    end

    def self.search_pix(key)
      pix = DB[:pix].where(key: key)
      pix.count
    end

    def self.search_username_with_key(key)
      DB[:pix].where(key: key).first[:username]
    end

    def self.search_pix_partial_key(partial_key)
      DB[:pix].where(Sequel.like(:key, "#{partial_key}%"))
    end
  end

  # Configure database schemas
  class Configure
    def self.create_tables
      DB.create_table :pix do
        primary_key :id
        String :username
        String :key_type
        String :key
      end
      DB.create_table :transactions do
        primary_key :id
        String :payer
        String :receiver
        Float :transaction_price
        DateTime :transaction_date
      end
    end
  end
end

# Database::Configure.create_tables
