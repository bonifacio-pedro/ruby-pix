require_relative 'pix'
require_relative 'transaction'
require_relative 'config'

if ARGV[0] == "--novo" or ARGV[0] == "-n"
    if ARGV[1] != nil and PIX_TYPES.include?(ARGV[1])
        if ARGV[2] != nil
            puts Pix.insert_data_new_pix(ARGV[1], ARGV[2])
        else
            puts "Adicione uma chave válida"
        end
    else
        puts "Coloque um tipo de chave pix válido!
        TIPOS VÁLIDOS:
            - CPF
            - TEL
            - EMAIL"
    end
elsif ARGV[0] == "--transacao" or ARGV[0] == "-t"
    if ARGV[1] != nil and ARGV[2] != nil
        transaction = Transaction.new(ARGV[1],ARGV[2])
    else
        puts "Adicione chaves válidas para a transação!"
    end
elsif ARGV[0] == "--help" or ARGV[0] == "-h"
    puts HELPER
else
    puts HELPER
end
        





