require_relative '../models/employee'
require 'csv'

class EmployeeRepository

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []

    load_csv
  end

  def all_delivery_guys
    @employees.reject { |employee| employee.manager? }
  end

  def find(id)
    @employees.find { |employee| employee.id == id }
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username }
  end

  private
  def load_csv
    csv_options = {
      headers: :first_row,
      header_converters: :symbol,
      col_sep: ',',
      quote_char: '"'
    }

    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id] = row[:id].to_i

      @employees << Employee.new(row)
    end
  end

end

# repo = EmployeeRepository.new('data/employees.csv')
# repo.all_delivery_guys.each do |employee|
#   puts employee.username
# end
# employee = repo.find_by_username('adilson')
# puts employee.username
