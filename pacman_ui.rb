require 'colorize'

def welcome_player
    system("cls")
    puts "Welcome to the pacman clone game"
    puts "Possible directions are: W, S, A and D"
    puts "What is your name?"
    name = gets.strip
    puts "\n"
    puts "Your game is starting, #{name}"
    name
end

def draw_map_in_the_prompt(map_data)
    puts map_data
end

def ask_the_direction
    possible_directions = ["W", "S", "A", "D"]
    puts "\n Where do you want to go:"

    loop do
        direction = gets.strip.upcase
        if possible_directions.include?(direction)
            return direction
        end

        puts "Choose a valid direction".red
    end
    
end

def ask_which_map
    puts "Choose which map you want to play with:"
    current_path = Dir.pwd
    txt_files_full_path = Dir["#{current_path}/*.txt"]
    txt_files_names = []
    txt_files_full_path.each do |full_file_path|
        if full_file_path.include?('map')
            map_name = File.open(full_file_path, &:readline)
            txt_files_names << map_name
        end
    end

    map_file_order = 0
    valid_numbers = []
    for map in txt_files_names
        map_file_order += 1
        map_name_text =  "#{map_file_order}: #{map}".green
        puts map_name_text
        valid_numbers << map_file_order
    end
    
    loop do
        map_number = gets

        if valid_numbers.include?(map_number.to_i)
            puts "\n\n"
            return map_number
        end

        puts "Please, choose a valid number".red
    end
end