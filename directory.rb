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

def print(students) # Prints info on each student
students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} chort)" 
  end
end
def print_footer(students) # prints a statment on the number of students
puts "Overall, we have #{students.count} great students"
end
def input_students
    puts "Please enter the names of the students"
    puts "To finish, just hit return twice"
    # create and empty array
    students = []
    # get the first name
    name = gets.chomp
    # while the name is not empty, repeat this code
    while !name.empty? do
        # add the student hash to the array
        students << {name: name, cohort: :november}
        puts "Now we have #{students.count} students"
        # get the next name from the user
        name = gets.chomp
    end
    # return the array of students
    students
end
#nothing happens if we dont call the methods
students = input_students
print_header
print(students)
print_footer(students)