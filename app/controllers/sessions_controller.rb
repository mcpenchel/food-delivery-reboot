require_relative '../views/sessions_view'

class SessionsController

  def initialize(employee_repository)
    @employee_repository = employee_repository
    @view = SessionsView.new
  end

  def sign_in
    # Lógica de autenticação
    username = @view.ask_for('username')
    password = @view.ask_for('password')

    employee = @employee_repository.find_by_username(username)

    if employee && employee.password == password
      @view.welcome_the_user(employee.username)
      return employee
    else
      @view.wrong_credentials
      # Chamada recursiva
      sign_in
    end
  end
end

# require_relative '../repositories/employee_repository'

# repo = EmployeeRepository.new('data/employees.csv')
# controller = SessionsController.new(repo)

# controller.sign_in
