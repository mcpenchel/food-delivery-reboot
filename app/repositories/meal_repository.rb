require 'csv'
require_relative '../models/meal'

class MealRepository

  def initialize(csv_file_path)
    @meals = []
    @csv_file_path = csv_file_path

    load_csv if File.exist?(@csv_file_path)
  end

  def find(id)
    @meals.find { |meal| meal.id == id }
  end

  def all
    @meals
  end

  def create(meal)
    next_id = @meals.empty? ? 1 : @meals.last.id + 1
    meal.id = next_id
    @meals << meal

    save_csv
  end

  private
  def save_csv
    csv_options = {
      col_sep: ',',
      quote_char: '"',
      force_quotes: true
    }

    # Este bloco não é um loop!
    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      csv << ['id', 'name', 'price']

      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
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

    # Este bloco é um loop!
    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id]    = row[:id].to_i
      row[:price] = row[:price].to_i

      # row não é uma hash.... mas parece MUITO com uma hash!

      @meals << Meal.new(row)
    end
  end

end

# repo = MealRepository.new('data/meals.csv')

# meal = Meal.new(name: "Carne cozida", price: 15)

# repo.create(meal)

# repo.all.each do |meal|
#   puts "#{meal.id}: #{meal.name}"
# end

# puts repo.find(1).name
