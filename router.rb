class Router

  def initialize(meals_controller, customers_controller)
    @meals_controller     = meals_controller
    @customers_controller = customers_controller
    @running = true
  end

  def run
    puts "Bem-vindo à Entrega do Fogão!!!"
    puts "-------------------------------"
    while @running
      # 1) Imprima para o usuário todas as opções
      display_options
      # 2) Pegue do usuário qual a opção ele/ela quer
      user_action = gets.chomp.to_i
      # 3) Roteie para o controller a opção (ou seja, execute o
      # método correto do controller correto)
      route_to(user_action)
    end
  end

  private
  def display_options
    puts "1. Liste todos os pratos"
    puts "2. Adicione um novo prato"
    puts "3. Liste todos os clientes"
    puts "4. Adicione um novo cliente"
    puts "9. Saia do programa"
  end

  def route_to(user_action)
    case user_action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 9 then @running = false
    else
      puts "Ops, opção inválida, tente de novo."
    end
  end

end
