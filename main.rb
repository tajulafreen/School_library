require './app'
require './optional'

def list_options
  'Please choose an option by entering a number:
    1 - List of all books
    2 - List of all people
    3 - Add a person
    4 - Create a book
    5 - Add a rental
    6 - List of all rentals for a given ID
    7 - Exit'
end

def intro
  "Welcome to School Library App!\n\n"
end

def main
  app = App.new
  option_handler = Option.new

  puts intro

  loop do
    puts list_options
    option = gets.chomp.to_i
    option_handler.option(option, app)
  end
end

main
