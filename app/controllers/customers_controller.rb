require_relative '../views/customers_view'
require_relative '../models/customer'

class CustomersController

  def initialize(customer_repo)
    @customer_repo = customer_repo
    @view = CustomersView.new
  end

  def list
    customers = @customer_repo.all
    @view.display(customers)
  end

  def add
    name    = @view.ask_for("nome")
    address = @view.ask_for("endereço")

    customer = Customer.new(name: name, address: address)

    @customer_repo.create(customer)
  end

end
