# encoding: UTF-8

module SecQuery
  # => SecQuery::FilingParser
  # SecQuery::FilingParser dispatches filings to parsers depending on term/type
  class FilingParser
    attr_reader :parser

    def initialize(filing)
      @filing = filing
      @parser = parser_for(filing.term)
    end

    def parser_for(term)
      stripped_term = term.to_s.gsub(/[^0-9a-z_ ]/i, '')
      parser_klass = "Sec#{ stripped_term.camelize }Parser"
      parser_klass.constantize.new
    rescue NameError
      NilParser.new(parser_klass)
    end

    def parse(&blk)
      parser.parse(@filing.content, &blk)
    end
  end

  class NilParser
    def initialize(klass = :unknown)
      puts "NilParser was initialized as #{ klass } was undefined."
      puts "Define #{ klass }#parse to handle these filings."
    end

    def parse(*); end
  end
end
