# Biblioteca de integração Moip em Ruby

## Descrição

A biblioteca Moip em Ruby é um conjunto de classes de domínio que facilitam, para o desenvolvedor Ruby, a utilização das funcionalidades que o Moip oferece na forma de APIs. Com a biblioteca instalada e configurada, você pode facilmente integrar funcionalidades como:

 - Criar [requisições de pedidos]
 - Criar [requisições de pagamentos] 
 - Consultar [pedidos por código] 
 - Consultar [pagamentos por código] 
 - Criar [contas de marketplace]
 - Consultar [contas de marketplace]
 
## Requisitos
 - [Ruby] 2.3.0+
 
## Instalação
- Adicione a biblioteca ao seu Gemfile.

```ruby
gem "moip_api", :git => "git://github.com/caverna-labs/moip_api.git"
```

 - Execute o comando `bundle install`.

Para fazer a autenticação, você precisará configurar as credenciais do Moip. Crie o arquivo `config/initializers/moip.rb` com o conteúdo abaixo.

```ruby
Moip.configure do |config|
  config.api_token        = "token do moip"
  config.api_secret       = "secret do moip"
  config.app_id           = 'id da app do moip'
  config.app_access_token = 'token de acesso da app moip'
  config.app_secret       = 'secret da app moip'
  config.app_redirect_uri = 'url de redirecionamento'
  config.environment      = [:development/:production] (ambiente)
end
```

## Pedidos
Para processar pagamentos o Moip exige que seja criado um pedido previamente onde são descristas dados relativos ao pedido como a lista do items que vão ser cobrados e a lista de possiveis recebedores de um pedido. Abaixo está a implementação da criação de um pedido

```ruby
require 'moip_api'

# especificação do valor de envido
@amount = Moip::Resource::Amount.new(currency: "BRL", subtotals: {shipping: 50})

# especificação do items ou serviços a serem processados no pagamento
@item = Moip::Resource::Item.new(detail: "Product 1", quantity: 2, price: 2000, product: "Description of a product...")

# especificação da lista das contas que vão receber pagamento na transação
@receiver = Moip::Resource::Receiver.new(type: "SECONDARY", moipAccount: {}, amount: {})

# especificação do endereço do cliente 
@address = Moip::Resource::Address.new(city: "São Paulo", complement: "8", street: "Avenida Faria Lima", streetNumber: "2927", zipCode: "0123400000", state: "SP", type: "SHIPPING", country: "BRA")

# especificação dos dados do cliente do pedido
@customer = Moip::Resource::Customer.new(ownId: 'fefe', fullname: 'jose atonio', email: 'teste@teste.com', taxDocument: {type: 'CPF', number: '037.852.496-83'}, phone: {countryCode: '55', areaCode: '86', number: '99999-9999'}, shippingAddress: @address)

# id próprio do pedido
@ownId = "pedido_exemplo_alecrim-001"

# Especificão final do pedido
@order = Moip::Resource::Order.new(ownId: @ownId, amount: @amount, items: [@item], customer: @customer)

@api = Moip::Api.new

@response = @api.order.create(@order)

```

## Pagamentos

## Contas secundárias

### Conectar contas já existentes

### Criar nova conta
