# translate string numbers into numerals
# scan through document

def run
  translate_input
end

def calibration_input
  path = 'calibration_input.txt'
  File.open(path)
end

def one_input
  '817sixqtvhxpfglj5kzmbtwofive'
end

def translate_input
  collection_of_updated_lines = []
  new_full_line = replace_string_with_numeral(one_input)
  collection_of_updated_lines << new_full_line
  collection_of_updated_lines
end

def numbers
  %w[one two three four five six seven eight nine]
end

def replace_string_with_numeral(line)
  things_found = find_string_match(line)
  puts(things_found)
  puts("Things found count: #{things_found.count}")
  things_found.each do |thing_found|
    new_line = line.gsub(/#{thing_found}/, convert_number(thing_found))
  end
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

