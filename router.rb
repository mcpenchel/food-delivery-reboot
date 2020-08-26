class Router

  # STUDENTS!!!!!
  # Se com dor de cabeça porque passou da marcação da linha,
  # e a ofensa está tirando seu sono quando tu roda rake,
  # refatore o initialize para receber uma hash de atributos
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller     = meals_controller
    @customers_controller = customers_controller
    @sessions_controller  = sessions_controller
    @orders_controller    = orders_controller
    @running = true
  end

  def run
    puts "Bem-vindo à Entrega do Fogão!!!"
    puts "-------------------------------"
    while @running

      # Autentique o usuário
      # Se não autenticar, tente autenticar de novo em loop
      # Só deixa avançar o usuário que foi autenticado

      @employee = @sessions_controller.sign_in

      while @employee
        if @employee.manager?
          display_options_for_manager
          user_action = gets.chomp.to_i
          route_to_manager_actions(user_action)
        else
          display_options_for_delivery
          user_action = gets.chomp.to_i
          route_to_delivery_actions(user_action)
        end
      end
    end
  end

  private
  def display_options_for_delivery
    puts "1. Marcar um pedido como entregue"
    puts "2. Listar os meus pedidos pendentes"
    puts "8. Deslogar"
    puts "9. Saia do programa"
  end

  def route_to_delivery_actions(user_action)
    case user_action
    when 1 then @orders_controller.mark_as_delivered(@employee)
    when 2 then @orders_controller.list_my_orders(@employee)
    when 8 then @employee = nil
    when 9
      @running  = false
      @employee = nil
    else
      puts "Ops, opção inválida, tente de novo."
    end
  end

  def display_options_for_manager
    puts "1. Liste todos os pratos"
    puts "2. Adicione um novo prato"
    puts "3. Liste todos os clientes"
    puts "4. Adicione um novo cliente"
    puts "5. Adicione um novo pedido"
    puts "6. Liste todos os pedidos pendentes"
    puts "8. Deslogar"
    puts "9. Saia do programa"
  end

  def route_to_manager_actions(user_action)
    case user_action
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 5 then @orders_controller.add
    when 6 then @orders_controller.list_undelivered_orders
    when 8 then @employee = nil
    when 9
      @running  = false
      @employee = nil
    else
      puts "Ops, opção inválida, tente de novo."
    end
  end

end
