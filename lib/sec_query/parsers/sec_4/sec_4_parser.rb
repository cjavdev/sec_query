class Sec4Parser
  attr_reader :content, :xsd_uri

  def initialize(filing)
    @xsd_uri = './ownership4Document.xsd.xml'
    @content = filing.content
  end

  def parse(&error_blk)
    error_blk.call(xml_errors) if block_given? && !valid?
  end

  def filing_xml
    ownership_document.to_xml
  end

  private

  def ownership_document
    Nokogiri::XML(content).xpath('//ownershipDocument')
  end

  def schema
    @schema ||= Nokogiri::XML::Schema(IO.read(xsd_uri))
  end

  def valid?
    xml_errors.empty?
  end

  def xml_errors
    @errors ||= schema.validate(filing_xml)
  end
end
