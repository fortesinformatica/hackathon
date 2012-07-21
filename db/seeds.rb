# encoding: UTF-8
Dir[Rails.root.join("#{Rails.root}/spec/factories/**/*.rb")].each {|f| require f}

user = FactoryGirl.create(:user, :nome => "admin", 
                                 :admin => true, 
                                 :email => "atlas@grupofortes.com.br", 
                                 :password => "testes")

rodrigo = FactoryGirl.create(:user, :nome => "Rodrigo Maia",
                                 :email => "rodrigomaia@grupofortes.com.br", 
                                 :password => "testes")

milfont = FactoryGirl.create(:user, :nome => "Christiano Milfont",
                                :email => "christianomilfont@grupofortes.com.br", 
                                :password => "testes")

alcides = FactoryGirl.create(:user, :nome => "Alcides Queiroz",
                                 :email => "alcidesqueiroz@grupofortes.com.br", 
                                 :password => "testes")

puts "User criado => #{user.email}"

cliente = FactoryGirl.create(:cliente, :nome => "Guanabara")
cliente2 = FactoryGirl.create(:cliente, :nome => "Bomfim", :implantacao => true)
cliente3 = FactoryGirl.create(:cliente, :nome => "Stark Industries")
puts "Clientes criados"

cliente.sistemas << FactoryGirl.create(:sistema, :nome => "AG")
cliente.sistemas << FactoryGirl.create(:sistema, :nome => "AC Fiscal")
cliente2.sistemas << FactoryGirl.create(:sistema, :nome => "Indica")

puts "Contratos firmados"

assinatura = FactoryGirl.create(:tipo_contrato, :nome => 'Assinatura')
Contrato.all.each do |contrato| 
  contrato.tipo_contrato = assinatura
  contrato.tempo_contratado = 10800
  contrato.save!
end

puts "Atribuidos tipos aos contratos"

cliente.contatos << FactoryGirl.create(:contato, :user => rodrigo)
cliente.contatos << FactoryGirl.create(:contato, :user => milfont)

cliente2.contatos << FactoryGirl.create(:contato, :user => milfont)
cliente2.contatos << FactoryGirl.create(:contato, :user => alcides)

puts "Contatos informados"

katia = FactoryGirl.create(:atendente, :nome => 'Katia', :user => user)
joao = FactoryGirl.create(:atendente, :nome => 'João', :user => rodrigo)
isabel = FactoryGirl.create(:atendente, :nome => 'Isabel', :user => milfont)

puts "Atendente criados"

erro = FactoryGirl.create(:natureza, :nome => 'Erro')
duvida = FactoryGirl.create(:natureza, :nome => 'Dúvida')
customizacao = FactoryGirl.create(:natureza, :nome => 'Customização')

puts "Natureza criados"

andamento = FactoryGirl.create(:status, :nome => 'Em Adamento')
iniciar = FactoryGirl.create(:status, :nome => 'A Iniciar')
concluido = FactoryGirl.create(:status, :nome => 'Concluído')

puts "Status criados"


FactoryGirl.create(:chamado, :titulo => 'Falha na Fatura', :responsavel => katia, :cliente => cliente, :natureza => erro, :status => andamento)
FactoryGirl.create(:chamado, :titulo => 'Estoque duplicado', :responsavel => joao, :cliente => cliente2, :natureza => duvida, :status => iniciar)
FactoryGirl.create(:chamado, :titulo => 'Relatório novo', :responsavel => isabel, :cliente => cliente3, :natureza => customizacao, :status => concluido)