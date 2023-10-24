# RUBY - PIX!
Uma aplicação em CLI, para fazer transações pix utilizando validações e adicionando chaves (PIX, CPF ou EMAIL)

! Para rodar tenha o Ruby em versão 3+

## Passos:
- git clone https://github.com/bonifacio-pedro/ruby-pix/
- cd ruby-pix
- bundle
- ruby app.rb -help

### Comandos:
* ruby app.rb --novo OU -n [tipo] [chave]
* ruby app.rb --transacao OU -t [chave-pagador] [chave-recebedor]
* ruby app.rb --transacoes OU -ta [mostra todas transações]
