class Multiplier
    attr_accessor :total, :building_array, :enabled
    attr_reader :file, :input

    START_STRING = "do()"
    END_STRING = "don't()"
    def initialize(input_filepath, enabled=false)
        @file = File.open(input_filepath)
        @input = file.readlines.map(&:strip)
        @building_array = []
        @result_array = []
        @enabled = enabled
    end

    def solve
        if @enabled
            extract_and_shrink!(@input.join(''))
        else
            regex_matcher(@input.join(''))
        end
        multiply_and_total
        puts(@result_array.sum)
    end

    # def scan_and_gather
    #
    #     @input.each do |row|
    #         regex_matcher(row)
    #     end
    # end

    def extract_and_shrink!(input_string)
        target = @enabled ? END_STRING : START_STRING
        last_run = false
        target_index = input_string.index(target)

        if target_index
            extracted = input_string[0..(target_index + target.length - 1)]
            remaining = input_string[(target_index + target.length)..-1]
        else
            puts "No target index found"
            last_run = true
            extracted = input_string
        end

        if target == END_STRING
            regex_matcher(extracted)
        end

        @enabled = !enabled
        unless last_run
            extract_and_shrink!(remaining)
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
puts(Multiplier.new('input_file.txt', true).solve)