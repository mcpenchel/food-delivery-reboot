class Meal

  attr_accessor :id
  attr_reader :name, :price

  def initialize(attributes = {})
    @id    = attributes[:id]
    @name  = attributes[:name]
    @price = attributes[:price]
  end

end

# meal = Meal.new(name: "Empadão de Legumes com arroz", price: 10)
# meal.id = 1

# puts "#{meal.id} - #{meal.name} - #{meal.price}"
