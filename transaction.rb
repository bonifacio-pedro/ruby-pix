require_relative 'config'
require_relative 'pix'
require 'tty-table'
include Config

class Transaction
    @payer
    @receiver
    @price
    @date

    def initialize(payer_key, receiver_key, price)
        @payer = payer_key
        @receiver = receiver_key
        @date = Time.new
        @price = price

        # If key exists
        if verify_keys()
            data = [@payer,@receiver,@date.inspect.to_s,price.to_f]
            DB.execute "INSERT INTO Transactions VALUES (?, ?, ?, ?)", data
            return puts transaction_table
        else
            return puts "Chaves não encontradas"
        end
    end

    def transaction_table
        table = TTY::Table.new(
            header: ['Pagador','Recebedor','Valor','Data e hora'],
            rows: [[@payer, @receiver, @price, @date.inspect.to_s[0..15]]])
        return table.render(:unicode)
    end

    def verify_keys()
        if Pix.search_pix(@payer).size == 0 or Pix.search_pix(@receiver).size == 0
            return false
        end
        return true
    end

    def self.return_all_transactions()
        return DB.execute "SELECT * FROM Transactions"
    end
end
