class ReportValidator
    attr_accessor :separated_reports, :valid_count, :unsafe_reports, :fixable_reports, :fixable_count
    attr_reader :file
    def initialize(input_filepath)
        @file = File.open(input_filepath)
        @separated_reports = []
        @unsafe_reports = []
        @fixable_reports = []
        @fixable_count = 0
        @valid_count = 0
    end

    # Need to be able to identify save vs un safe records
    # Need to be able to pop off unsafe record and run it through the validator again
    # And/or keep count of how many unsafe occurrences there are in an array
    #   If problem_count == 1, then SAFE

    def solve
        prepare_reports(file.readlines.map(&:strip))
        validate_reports(@separated_reports)
        @valid_count
    end

    def solve_fixable_reports
        prepare_reports(file.readlines.map(&:strip))
        validate_reports(@separated_reports)
        fix_reports
        @fixable_reports.length + @valid_count
    end

    def prepare_reports(full_list)
        full_list.each do |line|
            @separated_reports << line.split.map(&:to_i)
        end
    end

    def validate_reports(input_reports, is_for_fixing=false)
        @fixable_count = 0
        input_reports.each do |report|
            if is_for_fixing
                if is_increasing_or_decreasing?(report) && increments_of_three_or_fewer?(report)
                    @fixable_count += 1
                end
            else
                if is_increasing_or_decreasing?(report) && increments_of_three_or_fewer?(report)
                    @valid_count += 1
                else
                    @unsafe_reports << report
                end
            end
        end
    end

    def fix_reports
        @unsafe_reports.each do |report|
            if fixable_report?(report)
                @fixable_reports << report
            end
        end
    end

    def fixable_report?(report)
        subreports = generate_subreports(report)
        validate_reports(subreports, true)
        if @fixable_count > 0
            true
        else
            false
        end
    end

    def generate_subreports(report)
        sub_reports = []
        report.each_index do |index|
            modified_array = report[0...index] + report[index+1..-1]
            sub_reports << modified_array
        end
        sub_reports
    end

    def is_increasing_or_decreasing?(report)
        if report[0] != nil && report[1] != nil
            if report[0] > report[1]
                report == report.sort.reverse
            elsif report[0] < report[1]
                report == report.sort
            else
                false
            end
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
puts(ReportValidator.new('input_file.txt').solve_fixable_reports)