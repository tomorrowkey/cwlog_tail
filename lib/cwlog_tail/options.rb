module CwlogTail
  class Options
    DEFAULT_INTERVAL = 5

    def initialize(argv)
      @argv = argv
    end

    def follow?
      @argv.member?('-f') || @argv.member?('--follow')
    end

    def lines
      idx = @argv.index('-n') || @argv.index('--lines')
      return nil unless idx

      lines = @argv[idx + 1].to_i
      return nil if lines <= 0

      lines
    end

    def interval
      idx = @argv.index('--interval')
      return DEFAULT_INTERVAL unless idx

      interval = @argv[idx + 1].to_i
      return DEFAULT_INTERVAL if interval <= 0

      interval
    end
  end
end
