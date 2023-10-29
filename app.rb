require_relative 'config'
require_relative 'lib/pix'
require_relative 'lib/transaction'
require 'tty-spinner'
require 'tty-table'

system('clear')
spinner = TTY::Spinner.new('[:spinner] Carregando sistema...', format: :pulse_2)
spinner.auto_spin
sleep(2)
spinner.stop('Pronto!')
puts "\n"

case ARGV[0]
when '--novo'
  if !ARGV[1].nil? && Config::PIX_TYPES.include?(ARGV[1])
    if !ARGV[2].nil?
      sleep(1)
      puts Pix.insert_data_new_pix(ARGV[1], ARGV[2])
    else
      puts 'Adicione uma chave válida'
    end
  else
    puts 'Coloque um tipo de chave pix válido!
    TIPOS VÁLIDOS:
        - CPF
        - TEL
        - EMAIL'
  end
when '--transacao'
  if !ARGV[1].nil? && !ARGV[2].nil? && !ARGV[3].nil? && !ARGV[3].include?(',')
    sleep(1)
    Transaction.new(ARGV[1], ARGV[2], ARGV[3].to_f)
  else
    puts "Adicione chaves e um preço válido para a transação! exemplo:\n
    ruby app.rb -t [CHAVE VÁLIDA] [CHAVE VÁLIDA] 10.99"
  end
when '--transacoes'
  table = TTY::Table.new(
    header: ['Pagador', 'Recebedor', 'Data e hora', 'Valor']
  )
  transactions = Transaction.return_all_transactions
  transactions.each do |t|
    t[2] = t[2].inspect.to_s[1..16]
    table << t
  end
  puts table.render(:unicode)
when '--help' || '-h'
  puts Config::HELPER
when '--flush'
  DB.execute 'DELETE FROM Transactions'
  DB.execute 'DELETE FROM Pix'
else
  puts Config::HELPER
end
