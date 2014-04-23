# encoding: UTF-8

module SecQuery
  # => SecQuery::FilingParser
  # SecQuery::FilingParser dispatches filings to parsers depending on term/type
  class FilingParser
    def initialize(filing)
      @parser = parser_for(filing.term)
    end

    def parser_for(term)
      "Sec#{ term.to_s.camelize }Parser".constantize.new
    end

    def parse(*args, &blk)
      @parser.parse(*args, &blk)
    end
  end
end
