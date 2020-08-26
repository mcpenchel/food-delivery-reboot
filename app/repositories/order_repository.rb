require 'csv'
require_relative '../models/order'

class OrderRepository

  def initialize(orders_csv_path, meal_repository, customer_repository, employee_repository)
    @csv_file_path = orders_csv_path

    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository

    @orders = []

    load_csv if File.exist?(@csv_file_path)
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }
  end

  def create(order)
    next_id = @orders.empty? ? 1 : @orders.last.id + 1
    order.id = next_id

    @orders << order

    save_csv
  end

  def mark_as_delivered(order)
    order.deliver!

    save_csv
  end

  private
  def save_csv
    csv_options = {
      col_sep: ',',
      quote_char: '"',
      force_quotes: true
    }

    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      csv << ['id', 'delivered', 'meal_id', 'customer_id', 'employee_id']

      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end

  def load_csv
    csv_options = {
      headers: :first_row,
      header_converters: :symbol,
      col_sep: ',',
      quote_char: '"'
    }

    # id,delivered,meal_id,customer_id,employee_id

    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id]        = row[:id].to_i
      row[:delivered] = row[:delivered] == "true"

      row[:meal]     = @meal_repository.find(row[:meal_id].to_i)
      row[:customer] = @customer_repository.find(row[:customer_id].to_i)
      row[:employee] = @employee_repository.find(row[:employee_id].to_i)

      @orders << Order.new(row)
    end
  end

end
