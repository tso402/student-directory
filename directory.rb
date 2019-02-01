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
students.each_with_index do |student, index|
    if (student[:name].start_with? ("J")) && (student[:name].length < 12)
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort) and lives in #{:home}" 
    end
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
        # Ask which cohort they are in
        puts "Which cohort are you in?"
        cohort = gets.chomp
        # Ask where they live
        puts "Where do you live?"
        home = gets.chomp
        # add the student hash to the array
        students << {name: name, cohort: cohort, home: home}
        puts "Now we have #{students.count} students"
        # get the next name from the user
        puts "Another name?"
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