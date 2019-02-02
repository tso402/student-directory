@students = [] # An empty array that all methods can access

def print_header # print intial text
  puts "The students of Villians Academy"
  puts "-------------"
end

def print # Prints info on each student
  if @students.count == 0
    puts "No one has signed up :( "
    return 0
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
  # get the first name
  input = STDIN.gets
  input = input[0...-1]
  # while the name is not empty, repeat this code
    while !input.empty? do
      split = input.split(" ")
      name = split[0]
        if split.length < 2
          cohort = :november
        elsif split.length == 2
          cohort = split[1].to_sym
        else puts "Only two words please!!! Start again....."
        return input_students
        end
      # Ask where they live
      puts "Where do you live?"
      home = STDIN.gets
      home = home[0...-1]
      # add the student hash to the array
      add_students(name,cohort,home)
      if @students.count == 1
        puts "Now we have 1 student"
      else
        puts "Now we have #{@students.count} students"
      end
      # get the next name from the user
      puts "Another name?"
      input = STDIN.gets
      input = input[0...-1]
    end
  # return the array of students
  @students
end

def process(choice)
    case choice
      when "1"
        input_students  # input new students
      when "2"
        show_students # print current students
      when "3"
        puts "Which file to save to?"
        save_students(STDIN.gets.chomp) # Save the list of current students
      when "4"
        puts "Which file to load?"
        load_students(STDIN.gets.chomp) # Load a list of students from CSV
      when "5"
        remove_students
      when "6"
        puts "Which list to delete?"
        delete_save(STDIN.gets.chomp) # Select a list to delete
      when "9"
        exit # Exit the program
      else
        puts "That isn't an available option!"
    end
end    

def interactive_menu # Creating an interactive menu method to make my program easier to use
 try_load_students
 loop do
   # 1. print the menu and ask the user what option to choose
   print_menu
   # 2. read the input and carry out the option
   process(STDIN.gets.chomp)
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
    # open a file for writing
    File.open(filename,"w") { |file|
    # interate over my students array
    @students.each do |student|
        student_record = [student[:name], student[:cohort], student[:home]]
        csv_line = student_record.join(",")
        file.puts csv_line
    end
    }
    if @students.count == 1
        puts "#{@students.count} record was saved"
    else
      puts "#{@students.count} records were saved"
    end
    
end

def load_students(filename = "students.csv")
    if filename == ""
        filename = "students.csv"
    end
    @students = []
    if !File.exists? (filename)
        puts "Sorry, #{filename} doesn't exist!!"
        return
    else    
    File.open(filename, "r") { |file|
    n = 0
    file.readlines.each do |record|
        name, cohort, home = record.chomp.split(",")
        add_students(name,cohort,home)
        n += 1
    end
    if n == 1
      STDOUT.puts "#{n} record was loaded"
    else
      STDOUT.puts "#{n} records were loaded"
    end
    }
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
    puts "Enter a student to remove"
    removal = gets.chomp
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
    

#nothing happens if we dont call the methods
interactive_menu