require 'spec_helper'

describe Sec4Parser do
  let(:filing) { double('filing') }
  let(:filing1txt) do
    File.read(File.expand_path(File.dirname(__FILE__) + '/filing1.txt'))
  end

  let(:filing1xml) do
    Nokogiri::XML(
      File.read(
        File.expand_path(File.dirname(__FILE__) + '/filing1.xml')
      )
    ).xpath('//ownershipDocument').to_xml
  end

  it '#initialize takes the filing and exposes its content' do
    allow(filing).to receive(:content).and_return("Filing Content")
    parser = Sec4Parser.new(filing)
    expect(parser.content).to eq("Filing Content")
  end

  it '#filing_xml returns just the xml portion of the filing content' do
    allow(filing).to receive(:content).and_return(filing1txt)
    parser = Sec4Parser.new(filing)
    expect(parser.content).to eq(filing1txt)
    expect(parser.filing_xml).to eq(filing1xml)
  end

#   # describe '#parse' do
#   #   let(:doc) do
#   #     allow(filing).to receive(:content).and_return(filing1txt)
#   #     Sec4Parser.new(filing).parse
#   #   end
#
#   #   it 'parses the schemaVersion' do
#   #     expect(doc.schema_version).to eq('X0306')
#   #   end
#   # end
end
