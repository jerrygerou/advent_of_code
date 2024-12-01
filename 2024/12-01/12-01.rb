class ListSorter
    attr_accessor :left_list, :right_list, :differences
    attr_reader :file
    def initialize(input_filepath)
        @file = File.open(input_filepath)
        @left_list = []
        @right_list = []
        @differences = []
    end

    def solve
        prepare_lists(file.readlines.map(&:split))
        get_differences
        @differences.sum
    end

    def prepare_lists(full_list)
        full_list.each do |line|
            left_list.push(line[0])
            right_list.push(line[1])
        end
        @left_list = left_list.sort
        @right_list = right_list.sort
    end

    def get_differences
        @left_list.each_with_index do |left, index|
            difference = (left.to_i - @right_list[index].to_i).abs
            @differences.append(difference)
        end
    end
end


puts(ListSorter.new('input_file.txt').solve)