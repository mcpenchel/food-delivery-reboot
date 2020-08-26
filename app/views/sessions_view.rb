class SessionsView

  def ask_for(field)
    puts "> #{field}?"
    gets.chomp
  end

  def welcome_the_user(username)
    puts "Welcome #{username.capitalize}!"
  end

  def wrong_credentials
    puts "Wrong credentials... Try again!"
  end

end
