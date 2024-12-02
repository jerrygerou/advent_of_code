class ReportValidator
    attr_accessor :separated_reports, :valid_count, :unsafe_reports
    attr_reader :file
    def initialize(input_filepath)
        @file = File.open(input_filepath)
        @separated_reports = []
        @valid_count = 0
        @unsafe_reports = []
    end

    def solve
        prepare_reports(file.readlines.map(&:strip))
        validate_reports
        @valid_count
    end


    def prepare_reports(full_list)
        full_list.each do |line|
            @separated_reports << line.split.map(&:to_i)
        end
    end

    def validate_reports
        @separated_reports.each do |report|
            if is_increasing_or_decreasing?(report) && increments_of_three_or_fewer?(report)
                @valid_count += 1
            end
        end
    end

    def is_increasing_or_decreasing?(report)
        if report[0] > report[1]
            report == report.sort.reverse
        elsif report[0] < report[1]
            report == report.sort
        else
            false
        end
    end

    def increments_of_three_or_fewer?(report)
        return true if report.size <= 1

        difference = (report[0].to_i - report[1].to_i).abs
        return false if difference > 3 || difference < 1

        increments_of_three_or_fewer?(report[1..])
    end
end

puts(ReportValidator.new('input_file.txt').solve)