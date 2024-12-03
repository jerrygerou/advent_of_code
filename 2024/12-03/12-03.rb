class Multiplier
    attr_accessor :total, :building_array
    attr_reader :file, :input
    def initialize(input_filepath)
        @file = File.open(input_filepath)
        @input = file.readlines.map(&:strip)
        @building_array = []
        @result_array = []
    end

    def solve
        scan_and_gather
        multiply_and_total
        puts(@result_array.sum)
    end

    def scan_and_gather
        @input.each do |row|
            regex_matcher(row)
        end
    end

    def multiply_and_total
        @building_array.each do |sub_string|
            @result_array << multiplier(sub_string)
        end
    end

    def regex_matcher(input_string)
        regex = /mul\(\d{1,3},\d{1,3}\)/
        if input_string.match?(regex)
            puts "Match found: #{input_string.match(regex)}"
            sub_string = input_string.match(regex)[0]
            building_array << sub_string
            new_string = input_string.sub(sub_string, "Hohoho")
            regex_matcher(new_string)
        else
            puts "Moving on."
        end
    end

    def multiplier(input_string)
        numbers = input_string.scan(/\d{1,3}/)
        numbers = numbers.map(&:to_i)
        numbers[0] * numbers[1]
    end
end

puts(Multiplier.new('input_file.txt').solve)