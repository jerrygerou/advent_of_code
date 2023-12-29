
# cubes which are either red, green, or blue.
# Each time you play this game, he will hide a secret number
# of cubes of each color in the bag, and your goal is to
# figure out information about the number of cubes.
#
#
# 12 red cubes, 13 green cubes, and 14 blue cubes
#
# What is the sum of the IDs of those games?
#


# extract GameID, package up data
# split games on semi-colon
# method for - if_possible
# method for - add_total
#
def run
  data_input = collection_of_input
  game_data = game_data_into_hash(data_input)
  puts(data_input[13])
end

def game_data_into_hash(data_input)
  game_id = data_input.split(':')[0].gsub(/[^0-9]/, '').to_i
end

def test_input
  'Game 91: 9 red, 12 green, 1 blue; 11 green, 9 red, 2 blue; 1 blue, 8 red, 4 green; 6 red, 9 green; 2 blue, 10 red, 1 green; 2 blue, 15 green, 13 red'
end

def max_possibilities
  {
    'red': 12,
    'green': 13,
    'blue': 14
  }
end


def calibration_input
  path = 'input.txt'
  File.open(path)
end

def collection_of_input
  array_of_input = []
  calibration_input.each do |one_input|
    array_of_input << one_input
  end
  array_of_input
end

run