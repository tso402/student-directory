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

# New input that captures name and cohort in one go
def input_students
    puts "Please enter the names and cohort of the students"
    puts "To finish, just hit return twice"
    # create and empty array
    #students = []
    # get the first name
    input = gets
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
        home = gets
        home = home[0...-1]
        # add the student hash to the array
        @students << {name: name, cohort: cohort, home: home}
        if @students.count == 1
            puts "Now we have 1 student"
        else
        puts "Now we have #{@students.count} students"
        end
        # get the next name from the user
        puts "Another name?"
        input = gets
        input = input[0...-1]
    end
    # return the array of students
    @students
end

def process(choice)
    case choice
            when "1"
              # input new students
              input_students
            when "2"
              # print current students
              show_students
            when "9"
              exit # Exit the program
            else
              puts "That isn't an available option!"
    end
end    
# Creating an interactive menu method to make my program easier to use
def interactive_menu
 loop do
   # 1. print the menu and ask the user what option to choose
   print_menu
   # 2. read the input and carry out the option
   process(gets.chomp)
  end
end

def print_menu
    puts "Hello, please choose an option"
    puts "1. Enter new students"
    puts "2. Print a list of current students"
    puts "9. Exit the program"
end

def show_students
     print_header
     print
     print_footer
end
    
#nothing happens if we dont call the methods
interactive_menu