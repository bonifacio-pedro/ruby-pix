require_relative 'pix'
require_relative 'transaction'
require_relative 'config'
require 'tty-spinner'
require 'tty-table'

system('clear')
spinner = TTY::Spinner.new("[:spinner] Carregando sistema...", format: :pulse_2)
spinner.auto_spin
sleep(2)
spinner.stop("Pronto!")
puts "\n"

if ARGV[0] == "--novo" or ARGV[0] == "-n"
    if ARGV[1] != nil and PIX_TYPES.include?(ARGV[1])
        if ARGV[2] != nil
            sleep(1)
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
    if ARGV[1] != nil and ARGV[2] != nil and ARGV[3] != nil and not ARGV[3].include?(',')
        sleep(1)
        transaction = Transaction.new(ARGV[1],ARGV[2],ARGV[3].to_f)
    else
        puts "Adicione chaves e um preço válido para a transação! exemplo:\nruby app.rb -t [CHAVE VÁLIDA] [CHAVE VÁLIDA] 10.99 (EXEMPLO DE PREÇO)"
    end
elsif ARGV[0] == "--transacoes" or ARGV[0] == "-ta"
    table = TTY::Table.new(
        header: ['Pagador','Recebedor','Data e hora','Valor'])
    transactions = Transaction.return_all_transactions
    transactions.each do |transaction|
        transaction[2] = transaction[2].inspect.to_s[1..16]
        table << transaction
    end
    puts table.render(:unicode)
elsif ARGV[0] == "--help" or ARGV[0] == "-h"
    puts HELPER
elsif ARGV[0] == "--flush"
    DB.execute "DELETE FROM Transactions"
    DB.execute "DELETE FROM Pix"
else
    puts HELPER
end
