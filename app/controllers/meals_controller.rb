require_relative '../views/meals_view'
require_relative '../models/meal'

class MealsController

  def initialize(meal_repository)
    @meal_repository = meal_repository
    @view = MealsView.new
  end

  def add
    name  = @view.ask_for("nome")
    price = @view.ask_for("preço").to_i

    meal = Meal.new(name: name, price: price)

    @meal_repository.create(meal)
  end

  def list
    meals = @meal_repository.all
    @view.display(meals)
  end

end

# require_relative '../repositories/meal_repository'

# repo = MealRepository.new('data/meals.csv')
# controller = MealsController.new(repo)
# controller.list
# controller.add
