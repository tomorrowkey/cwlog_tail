module CwlogTail
  class Options
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
      return nil if lines == 0

      lines
    end
  end
end
