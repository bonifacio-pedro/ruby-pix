require_relative 'config'
require_relative 'lib/pix'
require_relative 'lib/transaction'
require 'tty-spinner'
require 'tty-table'

system('clear')
spinner = TTY::Spinner.new('[:spinner] Loading system...', format: :pulse_2)
spinner.auto_spin
sleep(2)
spinner.stop('Ready!')

case ARGV[0]
when '--new'
  if !ARGV[1].nil? && Config::PIX_TYPES.include?(ARGV[1])
    if !ARGV[2].nil?
      sleep(1)
      puts Pix.insert_data_new_pix(ARGV[1], ARGV[2])
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
    header: %W[Payer Receiver Datetime Price]
  )
  transactions = Transaction.return_all_transactions
  transactions.map { |t|
    t[2] = t[2].inspect.to_s[1..16]
    table << t
  }
  puts table.render(:unicode)
when '--search'
  if !ARGV[1].nil?
    puts Pix.search_key_initial(ARGV[1])
  else
    puts 'Enter a valid search parameter'
  end
when '--help'
  puts Config::HELPER
when '--flush'
  DB.execute 'DELETE FROM Transactions'
  DB.execute 'DELETE FROM Pix'
else
  puts Config::HELPER
end
