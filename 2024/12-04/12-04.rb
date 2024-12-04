class WordSearch
    attr_reader :file, :input, :board, :transposed_board

    STRING_TO_FIND = %w[X M A S]

    # 140 characters long, tall
    # Need to find STRING_TO_FIND[0]
    # And from there, grab all of the indexes of the possibilities to complete the word

    def initialize(input_filepath)
        @file = File.open(input_filepath)
        @input = file.readlines.map(&:split)
        @board = []
        @transposed_board = []
        @found_count = 0
    end

    def solve
        prepare_board
        run_through_board
        puts(@found_count)
    end

    def solve_for_x
        #478 too low
        prepare_board
        run_through_board_again
        puts(@found_count)
    end

    def prepare_board
        input.each do |line|
            @board << line[0].split('')
        end
        @transposed_board = @board.transpose
    end

    def run_through_board
        @board.each_with_index do |row, y_index|
            row.each_with_index do |_, x_index|
                find_forward(y_index, x_index)
                find_backward(y_index, x_index)
                find_top_to_bottom(y_index, x_index)
                find_bottom_to_top(y_index, x_index)
                find_diagonal_forward_up(y_index, x_index)
                find_diagonal_forward_down(y_index, x_index)
                find_diagonal_backward_up(y_index, x_index)
                find_diagonal_backward_down(y_index, x_index)
            end
        end
    end

    def run_through_board_again
        @board.each_with_index do |row, y_index|
            row.each_with_index do |_, x_index|
                find_mas_in_an_x(y_index, x_index)
            end
        end
    end

    def find_mas_in_an_x(y_index, x_index)
        return unless valid_x_coordinates?(y_index, x_index)

        if is_x_pattern_one?(y_index, x_index)
            puts "FOUND an X!"
            @found_count += 1
        end

        if is_x_pattern_two?(y_index, x_index)
            puts "FOUND an X!"
            @found_count += 1
        end

        if is_x_pattern_three?(y_index, x_index)
            puts "FOUND an X!"
            @found_count += 1
        end

        if is_x_pattern_four?(y_index, x_index)
            puts "FOUND an X!"
            @found_count += 1
        end
    end

    def valid_x_coordinates?(y_index, x_index)
        y_index - 1 >= 0 &&
        y_index + 1 < @board.size &&
        x_index - 1 >= 0 &&
        x_index + 1 < @board[y_index].size
    end


    def is_x_pattern_one?(y_index, x_index)
        # M.S
        # .A.
        # M.S
        @board[y_index][x_index] == 'A' &&
        @board[y_index - 1][x_index - 1] == 'M' &&
        @board[y_index - 1][x_index + 1] == 'S' &&
        @board[y_index + 1][x_index + 1] == 'S' &&
        @board[y_index + 1][x_index - 1] == 'M'
    end

    def is_x_pattern_two?(y_index, x_index)
        # S.M
        # .A.
        # S.M
        @board[y_index][x_index] == 'A' &&
        @board[y_index - 1][x_index - 1] == 'S' &&
        @board[y_index - 1][x_index + 1] == 'M' &&
        @board[y_index + 1][x_index + 1] == 'M' &&
        @board[y_index + 1][x_index - 1] == 'S'
    end

    def is_x_pattern_three?(y_index, x_index)
        # M.M
        # .A.
        # S.S
        @board[y_index][x_index] == 'A' &&
        @board[y_index - 1][x_index - 1] == 'M' &&
        @board[y_index - 1][x_index + 1] == 'M' &&
        @board[y_index + 1][x_index + 1] == 'S' &&
        @board[y_index + 1][x_index - 1] == 'S'
    end

    def is_x_pattern_four?(y_index, x_index)
        # S.S
        # .A.
        # M.M
        @board[y_index][x_index] == 'A' &&
        @board[y_index - 1][x_index - 1] == 'S' &&
        @board[y_index - 1][x_index + 1] == 'S' &&
        @board[y_index + 1][x_index + 1] == 'M' &&
        @board[y_index + 1][x_index - 1] == 'M'
    end

    def find_forward(y_index, x_index)
        if x_index + 3 < @board[y_index].size &&
            STRING_TO_FIND.each_with_index.all? { |char, i| @board[y_index][x_index + i] == char }
            puts "FOUND ONE (forward)!"
            @found_count += 1
        end
    end

    def find_backward(y_index, x_index)
        if x_index - 3 >= 0 &&
            STRING_TO_FIND.each_with_index.all? { |char, i| @board[y_index][x_index - i] == char }
            puts "FOUND ONE (backward)!"
            @found_count += 1
        end
    end

    def find_top_to_bottom(y_index, x_index)
        if y_index + 3 < @board.size &&
            STRING_TO_FIND.each_with_index.all? { |char, i| @board[y_index + i][x_index] == char }
            puts "FOUND ONE (top to bottom)!"
            @found_count += 1
        end
    end

    def find_bottom_to_top(y_index, x_index)
        if y_index - 3 >= 0 &&
            STRING_TO_FIND.each_with_index.all? { |char, i| @board[y_index - i][x_index] == char }
            puts "FOUND ONE (bottom to top)!"
            @found_count += 1
        end
    end

    def find_diagonal_forward_up(y_index, x_index)
        if y_index + 3 < @board.size && x_index + 3 < @board[y_index].size &&
            STRING_TO_FIND.each_with_index.all? { |char, i| @board[y_index + i][x_index + i] == char }
            puts "FOUND ONE (diagonal forward up)!"
            @found_count += 1
        end
    end

    def find_diagonal_forward_down(y_index, x_index)
        if y_index - 3 >= 0 && x_index + 3 < @board[y_index].size &&
            STRING_TO_FIND.each_with_index.all? { |char, i| @board[y_index - i][x_index + i] == char }
            puts "FOUND ONE (diagonal forward down)!"
            @found_count += 1
        end
    end

    def find_diagonal_backward_up(y_index, x_index)
        if y_index + 3 < @board.size && x_index - 3 >= 0 &&
            STRING_TO_FIND.each_with_index.all? { |char, i| @board[y_index + i][x_index - i] == char }
            puts "FOUND ONE (diagonal backward up)!"
            @found_count += 1
        end
    end

    def find_diagonal_backward_down(y_index, x_index)
        if y_index - 3 >= 0 && x_index - 3 >= 0 &&
            STRING_TO_FIND.each_with_index.all? { |char, i| @board[y_index - i][x_index - i] == char }
            puts "FOUND ONE (diagonal backward down)!"
            @found_count += 1
        end
    end

end

# puts(WordSearch.new('input_file.txt').solve)
puts(WordSearch.new('input_file.txt').solve_for_x)
# puts(WordSearch.new('test_input.txt').solve)
# puts(WordSearch.new('x_test_input.txt').solve_for_x)