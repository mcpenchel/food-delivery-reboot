class CustomersView

  def ask_for(field)
    puts "Qual é o #{field}?"
    gets.chomp
  end

  def display(customers)
    customers.each do |customer|
      puts "#{customer.id}. #{customer.name}, que mora em #{customer.address}"
    end
  end

end
