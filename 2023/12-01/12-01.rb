def run
  collection_of_updated_lines = translate_input
  make_additions(collection_of_updated_lines)
end

def make_additions(collection_of_updated_lines)
  numbers_to_add = []
  collection_of_updated_lines.each do |line|
    first_digit = line.scan(/\d/)[0,1][0]
    last_digit = line.scan(/\d/)[-1,1][0]
    sum_of_first_and_last = first_digit + last_digit
    numbers_to_add << sum_of_first_and_last.to_i
  end
  numbers_to_add.sum
end

def calibration_input
  path = 'calibration_input.txt'
  File.open(path)
end

def collection_of_input
  array_of_input = []
  calibration_input.each do |one_input|
    array_of_input << one_input
  end
  array_of_input
end

def translate_input
  collection_of_updated_lines = []
  collection_of_input.each do |one_input|
    new_full_line = replace_string_with_numeral(one_input)
    collection_of_updated_lines << new_full_line
  end
  collection_of_updated_lines
end

def replace_string_with_numeral(line)
  things_found = find_string_match(line)
  things_found.each do |thing_found|
    line = line.gsub(/#{thing_found}/, convert_number(thing_found))
  end
  line
end

def find_string_match(line)
  matches = []
  numbers.each do |number|
    if line.match(number)
      matches << number
    end
  end
  matches
end

def numbers
  %w[one two three four five six seven eight nine]
end

def convert_number(number_string)
  if number_string == 'one'
    1.to_s
  elsif number_string == 'two'
    2.to_s
  elsif number_string == 'three'
    3.to_s
  elsif number_string == 'four'
    4.to_s
  elsif number_string == 'five'
    5.to_s
  elsif number_string == 'six'
    6.to_s
  elsif number_string == 'seven'
    7.to_s
  elsif number_string == 'eight'
    8.to_s
  elsif number_string == 'nine'
    9.to_s
  end
end

run

