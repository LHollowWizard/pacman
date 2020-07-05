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
    case direction
    when "W"
        player[0] -= 1
    when "S"
        player[0] += 1
    when "A"
        player[1] -= 1
    when "D"
        player[1] += 1
    end

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

def is_direction_possible?(direction, player, map_data)
    temp_player = player.dup
    case direction
    when "W"
        temp_player[0] -= 1
    when "S"
        temp_player[0] += 1
    when "A"
        temp_player[1] -= 1
    when "D"
        temp_player[1] += 1
    end

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