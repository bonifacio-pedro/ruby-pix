# RUBY - PIX!
A CLI application to carry out pix transactions using validations and adding keys (CELLPHONE, CPF or EMAIL)

### To run, have Ruby version 3+

## Steps:
- git clone https://github.com/bonifacio-pedro/ruby-pix/
- cd ruby-pix
- bundle
- ruby app.rb --db
- ruby app.rb --help

### Commands:
* ruby app.rb --new [username] [type] [key] (Add a new PIX Key)
* ruby app.rb --transaction [payer-key] [receiver-key] [price] (Add a new transaction)
* ruby app.rb --transactions (Show all transactions)
* ruby app.rb --search [key-search] (Search for similar pix keys)
* ruby app.rb --db (Configure DB)

