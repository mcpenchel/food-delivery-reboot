require_relative '../views/orders_view'
require_relative '../models/order'

class OrdersController

  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository

    @view = OrdersView.new
  end

  def add
    @view.display_meals(@meal_repository.all)
    meal_index = @view.ask_for_index("meal")
    meal = @meal_repository.all[meal_index]

    @view.display_customers(@customer_repository.all)
    customer_index = @view.ask_for_index("customer")
    customer = @customer_repository.all[customer_index]

    @view.display_employees(@employee_repository.all_delivery_guys)
    employee_index = @view.ask_for_index("employee")
    employee = @employee_repository.all_delivery_guys[employee_index]

    order = Order.new(meal: meal, customer: customer, employee: employee)

    @order_repository.create(order)
  end

  def list_undelivered_orders
    orders = @order_repository.undelivered_orders
    @view.display_orders(orders)
  end

  def list_my_orders(employee)
    orders = @order_repository.undelivered_orders

    filtered_orders = orders.select do |order|
      order.employee.id == employee.id
    end

    @view.display_orders(filtered_orders)

    return filtered_orders
  end

  def mark_as_delivered(employee)
    orders = list_my_orders(employee)
    order_index = @view.ask_for_index("order")

    order = orders[order_index]
    @order_repository.mark_as_delivered(order)
  end

end
