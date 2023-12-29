def run
  collection_of_updated_lines = translate_input
  puts(make_additions(collection_of_updated_lines))
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
    puts(one_input)
    new_full_line = replace_string_with_numerals(one_input)
    puts(new_full_line)
    collection_of_updated_lines << new_full_line
  end
  collection_of_updated_lines
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

def replace_string_with_numerals(line)
  regex = Regexp.new(number_mapping.keys.map { |x| Regexp.escape(x) }.join('|'))

  line.gsub(regex, number_mapping)
end

def number_mapping
  {
    'one': 1,
    'two': 2,
    'three': 3,
    'four': 4,
    'five': 5,
    'six': 6,
    'seven': 7,
    'eight': 8,
    'nine': 9
  }
end

run