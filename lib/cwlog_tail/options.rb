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
      if idx.nil?
        nil
      else
        @argv[idx + 1].to_i
      end
    end
  end
end
