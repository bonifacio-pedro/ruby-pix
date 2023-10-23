require_relative 'config'
require_relative 'pix'
include Config

class Transaction
    @payer
    @receiver
    @date

    def initialize(payer_key, receiver_key)
        @payer = payer_key
        @receiver = receiver_key
        @date = Time.new

        # If key exists
        if verify_keys()
            DB.execute "INSERT INTO Transactions VALUES (?, ?, ?)", [@payer,@receiver,@date.inspect.to_s]
            return puts "Transação ocorrida com sucesso na data #{@date.inspect.to_s[0..15]}"
        else
            return puts "Chaves não encontradas"
        end
    end

    def verify_keys()
        if Pix.search_pix(@payer).size == 0 or Pix.search_pix(@receiver).size == 0
            return false
        end
        return true
    end
end