#let's put all students into an array
students = [
    {name: "Dr. Hannibal Lecter", cohort: :november},
    {name: "Darth Vader",cohort: :november},
    {name: "Nurse Ratched",cohort: :november},
    {name: "Michael Corleone",cohort: :november},
    {name: "Alex DeLarge",cohort: :november},
    {name: "The Wicked Witch of the West",cohort: :november},
    {name: "Terminator",cohort: :november},
    {name: "Freddy Krueger",cohort: :november},
    {name: "The Joker",cohort: :november},
    {name: "Joffrey Baratheon",cohort: :november},
    {name: "Norman Bates",cohort: :november}
]

def print_header # print intial text
puts "The students of Villians Academy"
puts "-------------"
end
=begin
def print(students) # Prints info on each student
students.each_with_index do |student, index|
    if (student[:name].start_with? ("J")) && (student[:name].length < 12)
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort) and lives in #{:home}".center(30) 
    end
  end
end
end
=end
# Rewrite the each() method that prints all students using while or until control flow methods (Loops). (CURRENTLY STUCK)
def print(students) # Prints info on each student
 n = 0
 while n < students.count
 student = students[n]
    if (student[:name].start_with? ("J")) && (student[:name].length < 12)
    puts "#{n + 1}. #{student[:name]} (#{student[:cohort]} cohort) and lives in #{:home}".center(30) 
    n += 1
    end
 end
end


def print_footer(students) # prints a statment on the number of students
puts "Overall, we have #{students.count} great students"
end
# New input that captures name and cohort in one go
def input_students
    puts "Please enter the names and cohort of the students"
    puts "To finish, just hit return twice"
    # create and empty array
    students = []
    # get the first name
    input = gets.chomp
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
        home = gets.chomp
        # add the student hash to the array
        students << {name: name, cohort: cohort, home: home}
        puts "Now we have #{students.count} students"
        # get the next name from the user
        puts "Another name?"
        input = gets.chomp
    end
    # return the array of students
    students
end
#nothing happens if we dont call the methods
students = input_students
print_header
print(students)
print_footer(students)