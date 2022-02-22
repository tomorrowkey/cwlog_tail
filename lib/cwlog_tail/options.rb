module CwlogTail
  class Options
    DEFAULT_INTERVAL = 5
    DEFAULT_PAGE_COUNT = 3

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

    def page_count
      idx = @argv.index('--page_count')
      return DEFAULT_PAGE_COUNT unless idx

      page_count = @argv[idx + 1].to_i
      return DEFAULT_PAGE_COUNT if page_count <= 0

      page_count
    end

    def log_group
      idx = @argv.index('--log_group')
      return nil unless idx

      @argv[idx + 1]
    end

    def log_stream
      idx = @argv.index('--log_stream')
      return nil unless idx

      @argv[idx + 1]
    end

    def version?
      @argv.member?('--version')
    end
  end
end
