class MealsView

  def ask_for(field)
    puts "Qual é o #{field}?"
    gets.chomp
  end

  def display(meals)
    meals.each do |meal|
      puts "#{meal.id}. #{meal.name}, R$ #{meal.price}"
    end
  end

end
