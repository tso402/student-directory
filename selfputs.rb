def state_purpose
  puts "I am a self reading piece of code"
  puts ""
end

def read_yourself
  File.open(__FILE__,"r") {|file|
    file.readlines.each do |line|
      puts line
    end
  }
end

state_purpose
read_yourself