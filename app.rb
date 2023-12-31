require 'date'
require './person'
require './book'
require './classroom'
require './student'
require './teacher'
require './rental'

class App
  attr_accessor :people, :books, :rental

  def initialize
    @people = []
    @books = []
    @rental = []
  end

  def list_books
    @books.each { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
  end

  def list_people
    @people.each { |person| puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" }
  end

  def create_person
    print 'Do you want to Create a student (1) or a teacher (2)? [Input the number]: '
    select_person = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Age: '
    age = gets.chomp.to_i
    case select_person
    when 1
      print 'Has parent permission? [Y/N]: '
      permission = gets[0].capitalize
      permission = permission == 'Y'
      @people << Student.new(nil, age, name, permission)
    when 2
      print 'Specialization: '
      specialization = gets.chomp
      @people << Teacher.new(age, name, specialization)
    end
    puts 'Person created successfully'
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @books << Book.new(title, author)
    puts 'Book created successfully'
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index { |book, index| puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}" }
    book_number = gets.chomp.to_i
    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_number = gets.chomp.to_i
    print 'Date (YYYY-MM-DD): '
    date_input = gets.chomp
    return unless date_input.match(/^\d{4}-\d{2}-\d{2}$/)

    begin
      date = Date.parse(date_input)
      @rental << Rental.new(date, @people[person_number], @books[book_number])
      puts 'Rental created successfully'
    rescue ArgumentError
      puts 'Invalid date format. Please use the format YYYY-MM-DD.'
    end
  end

  def list_rentals
    print 'ID of person: '
    id = gets.chomp.to_i
    puts 'Rentals: '
    @rental.each do |rental|
      puts "Date: #{rental.date}, Book: \"#{rental.book.title} by #{rental.book.author}\"" if rental.person.id == id
    end
  end

  def stop
    puts 'Thank you for using this app!'
    exit
  end
end
