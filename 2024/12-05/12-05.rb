class PageOrderer
    attr_reader :file, :input
    attr_accessor :rules, :page_numbers, :solutions
    def initialize(input_filepath)
        @file = File.open(input_filepath)
        @input = file.readlines.map(&:split)
        @rules = []
        @page_numbers = []
        @solutions = []
    end

    def solve
        prepare_sections
        solve_problem
    end

    def solve_reorder
        prepare_sections
        solve_reorder_problem
    end

    def prepare_sections
        @input.each do |line|
            if line.nil? || line.empty?
                next
            end
            if line[0].include?('|')
                @rules << line[0].split('|').map(&:to_i)
            else
                @page_numbers << line[0].split(',').map(&:to_i)
            end
        end
    end


    def valid_update?(update, rules)
        rules.all? do |x, y|
            if update.include?(x) && update.include?(y)
                update.index(x) < update.index(y) # x must come before y
            else
                true
            end
        end
    end

    def solve_problem
        valid_updates = []
        page_numbers.each do |update|
            valid = true
            rules.each do |left, right|
                if update.include?(left) && update.include?(right)
                    unless update.index(left) < update.index(right)
                        valid = false
                        break
                    end
                end
            end
            valid_updates << update if valid
        end

        middle_pages = []
        valid_updates.each do |update|
            middle_pages << update[update.length / 2]
        end

        middle_pages.sum
    end

    def solve_reorder_problem
        
    end

end

puts(PageOrderer.new('input.txt').solve)
puts(PageOrderer.new('input.txt').solve_reorder)