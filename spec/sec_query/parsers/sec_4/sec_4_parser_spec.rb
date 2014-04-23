require 'spec_helper'

describe Sec4Parser do
  let(:filing) { double('filing') }

  before(:each) do
    allow(filing).to receive(:content).and_return("Filing Content")
  end

  it '#initialize takes the filing and exposes its content' do
    parser = Sec4Parser.new(filing)
    expect(parser.content).to eq("Filing Content")
  end

  it '#parse returns a populated document containing methods for form4' do
    parser = Sec4Parser.new(filing)
    doc = parser.parse
    expect(doc).to respond_to(:schema_version)
  end
end
