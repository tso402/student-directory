require "csv"
@students = [] # An empty array that all methods can access

def print_header # print intial text
  puts "The students of Villians Academy"
  puts "-------------"
end

def print # Prints info on each student
  if @students.count == 0
    puts "No one has signed up :( "
    return
  end
    n = 0
    info = []
    cohorts = []
    while n < @students.count
      student = @students[n]
        if (student[:name].start_with? ("J")) && (student[:name].length < 12)
          cohorts.push(student[:cohort].to_s).uniq!
          info.push("#{n + 1}. #{student[:name]} (#{student[:cohort]} cohort) and lives in #{student[:home]}".center(30)) 
          n += 1
        end
    end
    cohorts.sort!
    cohorts.each do |cohort|
      puts cohort.upcase
      info.each do |person|
        if person.to_s.include? cohort.to_s
          puts person
        end
      end
    end
end

def print_footer # prints a statment on the number of students
  if @students.count == 1
    puts puts "Overall, we have 1 great student"
  else
    puts "Overall, we have #{@students.count} great students"
  end
end

def input_students # New input that captures name and cohort in one go
  puts "Please enter the names and cohort of the students"
  puts "To finish, just hit return twice"
  input = STDIN.gets[0...-1]  # get the first name
  while !input.empty? do  # while the name is not empty, repeat this code
    split = input.split(" ")
    name = split[0]
      if split.length < 2
        cohort = :november
      elsif split.length == 2
        cohort = split[1].to_sym
      else puts "Only two words please!!! Start again....."
        return input_students
      end
    puts "Where do you live?"  # Ask where they live
    home = STDIN.gets[0...-1]
    add_students(name,cohort,home) # add the student hash to the array
    if @students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{@students.count} students"
    end
    puts "Another name?"  # get the next name from the user
    input = STDIN.gets[0...-1]
  end
end

def process(choice)
  case choice
    when "1"
      input_students  # input new students
    when "2"
      show_students # print current students
    when "3"
      puts "Which file to save to?"
      save_students(STDIN.gets[0...-1]) # Save the list of current students
    when "4"
      puts "Which file to load?"
      load_students(STDIN.gets[0...-1]) # Load a list of students from CSV
    when "5"
      remove_students
    when "6"
      puts "Which list to delete?"
      puts Dir["*.csv"]
      delete_save(STDIN.gets[0...-1]) # Select a list to delete
    when "9"
      exit # Exit the program
    else
      puts "That isn't an available option!"
  end
end    

def interactive_menu # Creating an interactive menu method to make my program easier to use
  loop do
    print_menu  # 1. print the menu and ask the user what option to choose
    process(STDIN.gets[0...-1])  # 2. read the input and carry out the option
  end
end

def print_menu
  puts "Hello, please choose an option"
  puts "1. Enter new students"
  puts "2. Print a list of current students"
  puts "3. Save your student list"
  puts "4. Load a student list"
  puts "5. Remove a student"
  puts "6. Delete a student list"
  puts "9. Exit the program"
end

def show_students
  print_header
  print
  print_footer
end

def save_students(filename = "students.csv")
  if filename == ""
    filename = "students.csv"
  end
  if @students.length == 0
    puts "No students to save!!"
      return
  end
  CSV.open(filename, "wb") do |csv|  # open a CSV for writing
    @students.each do |student| # interate over my students array
      student_record = [student[:name], student[:cohort], student[:home]]
      csv << student_record
    end
  end
  if @students.count == 1
    puts "#{@students.count} record was saved to #{filename}"
  else
    puts "#{@students.count} records were saved to #{filename}"
  end
end

def load_students(filename = "students.csv")
  if filename == ""
    filename = "students.csv"
  end
  if !File.exists? (filename)
    puts "Sorry, #{filename} doesn't exist!!"
    return
  else
  @students = []
  n = 0
  CSV.foreach(filename) do |row|
    name, cohort, home = row[0], row[1], row[2]
    add_students(name,cohort,home)
    n += 1
  end
  if n == 1
    STDOUT.puts "#{n} record was loaded from #{filename}"
  else
    STDOUT.puts "#{n} records were loaded from #{filename}"
  end
  end
end

def try_load_students
  filename = ARGV.first # First argunment supplied from the command line
  if filename.nil?
    filename = "students.csv"
  end
  if File.exists? (filename) # If the file exists
    load_students(filename)
    puts "Loaded students from #{filename}"
  elsif !File.exists? (filename) && filename = "students.csv"
    return
  else # If the file doesn't exist
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

def add_students(name,cohort,home)
  @students << {name: name, cohort: cohort.to_sym, home: home}
end

def remove_students
  if @students.length == 0
    puts "No one to remove"
    return
  end
  print
  puts "Enter a student to remove"
  removal = gets[0...-1]
  if removal == ""
    puts "You didn't enter a name"
    return
  end
  if @students.any? {|student| student[:name] == removal}
    @students.delete_if {|student| student[:name] == removal}
    puts "#{removal} was removed"
  else puts "#{removal} isn't a current student"
    return
  end
end

def delete_save(filename)
  if filename == ""
    puts "No save file given"
    return
  end
  if !File.exists? (filename)
    puts "#{filename} doesn't exist"
    return
  else File.delete(filename)
    puts "#{filename} was deleted"
  end
end

try_load_students #nothing happens if we dont call the methods
interactive_menu