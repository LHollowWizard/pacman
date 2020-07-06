require_relative 'pacman_ui'

def read_map(map_number)
    archive_name = "map#{map_number.strip}.txt"
    map_file = File.open(archive_name)
    start_of_map = 2
    end_of_map = map_file.size
    map_data = map_file.read.split("\n")[start_of_map, end_of_map]
    map_file.close
    map_data

end

def calculates_new_direction(player, direction)
    movements = {
        "W" => [-1, 0],
        "S" => [+1, 0],
        "A" => [0, -1],
        "D" => [0, +1]
        }

    movement = movements[direction]
    player[0] += movement[0]
    player[1] += movement[1]
    player
end

def find_player(map_data)
    player_char = "H"
    map_data.each_with_index do |current_line, line_index|
        player_column = current_line.index(player_char)
        if player_column
            return [line_index, player_column]
        end
    end

    #No player character
end

def find_phantasm(map_data)
    phantasm_char = "P"
    phantasms = []
    map_data.each_with_index do |current_line, line_index|
        phantasm_column = current_line.index(phantasm_char)
        if player_column
             phantasms << [line_index, player_column]
        end
    end
    phantasms
    #No phantasm character
end

def move_phantasms(map_data)
    phantasms = find_phantasm(map_data)

    phantasms.each do |phantasm|
        find_path_to_player
    end

def is_direction_possible?(direction, player, map_data)
    temp_player = player.dup

    movements = {
        "W" => [-1, 0],
        "S" => [+1, 0],
        "A" => [0, -1],
        "D" => [0, +1]
        }

    movement = movements[direction]
    temp_player[0] += movement[0]
    temp_player[1] += movement[1]

    char_in_the_map = map_data[temp_player[0]][temp_player[1]]
    wall = "#"
    phantasm = "P"
    colision_with_wall = char_in_the_map == wall
    colision_with_phantasm = char_in_the_map == phantasm
    if colision_with_wall || colision_with_phantasm 
        return false
    end

    true
end    


def play
    map = read_map(ask_which_map)

    loop do
        system("cls")
        draw_map_in_the_prompt(map)
        player =  find_player(map)

        loop do
            direction = ask_the_direction
            if is_direction_possible?(direction, player, map)
                map[player[0]][player[1]] = "."
                player = calculates_new_direction(player, direction)
                map[player[0]][player[1]] = "H"
                break
            end
            system("cls")
            puts "The direction you chose has a colision, choose another".red
            draw_map_in_the_prompt(map)
        end
    end
end

def start_game
    loop do
        name = welcome_player
        play
    end
end