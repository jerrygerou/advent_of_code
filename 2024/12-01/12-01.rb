class ListSorter
    attr_accessor :left_list, :right_list, :differences, :similarities
    attr_reader :file
    def initialize(input_filepath)
        @file = File.open(input_filepath)
        @left_list = []
        @right_list = []
        @differences = []
        @similarities = []
    end

    def solve_similarities
        prepare_lists(file.readlines.map(&:split))
        left_list.each do |left|
            number_to_find = left
            number_of_occurrences_in_right = 0
            right_list.each do |right|
                if number_to_find == right
                    number_of_occurrences_in_right += 1
                end
            end
            @similarities.append(number_to_find * number_of_occurrences_in_right)
        end
        @similarities.sum
    end

    def solve_differences
        prepare_lists(file.readlines.map(&:split))
        @left_list = left_list.sort
        @right_list = right_list.sort
        get_differences
        @differences.sum
    end

    def prepare_lists(full_list)
        full_list.each do |line|
            left_list.push(line[0].to_i)
            right_list.push(line[1].to_i)
        end
    end

    def get_differences
        @left_list.each_with_index do |left, index|
            difference = (left - @right_list[index]).abs
            @differences.append(difference)
        end
    end
end


# puts(ListSorter.new('input_file.txt').solve_differences)
puts(ListSorter.new('input_file.txt').solve_similarities)