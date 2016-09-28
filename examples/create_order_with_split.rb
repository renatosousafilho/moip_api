require 'moip_api'
require 'pry'
require_relative './configuration'

@amount = Moip::Resource::Amount.new(currency: "BRL", subtotals: {shipping: 50})

@receiver = Moip::Resource::Receiver.new(type: "SECONDARY", moipAccount: {}, amount: {})

@item = Moip::Resource::Item.new(detail: "Product 1", quantity: 2, price: 2000, product: "Description of a product...")

@address = Moip::Resource::Address.new(city: "São Paulo", complement: "8", street: "Avenida Faria Lima", streetNumber: "2927", zipCode: "0123400000", state: "SP", type: "SHIPPING", country: "BRA")

@order = Moip::Resource::Order.new(own_id: "0001", amount: @amount, receivers: [@receiver], items: [@item], customer: 201)

@api = Moip::Api.new

# @response = @api.order.create(@order.to_json)

binding.pry
