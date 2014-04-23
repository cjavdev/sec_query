class Sec4Parser
  attr_reader :content

  def initialize(filing)
    @content = filing.content
  end

  def parse(&error_blk)
    p content[0..80]
  end
end
