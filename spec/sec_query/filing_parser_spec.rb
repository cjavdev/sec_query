# encoding: utf-8

include SecQuery
require 'spec_helper'

describe SecQuery::FilingParser do
  let(:filing) { double('filing') }

  before(:each) do
    class SecTestFormParser; end
    filing.stub(:term).and_return('TestForm')
  end

  it 'requires an argument is passed' do
    expect do
      SecQuery::FilingParser.new
    end.to raise_error(ArgumentError)
  end

  it 'requires argument responds to :term (SecQuery::Filing has term)' do
    expect do
      SecQuery::FilingParser.new({})
    end.to raise_exception(NoMethodError)
  end

  it 'sets up an internal parser of type Sec#{ type }Parser' do
    test_parser_count = ObjectSpace.each_object(SecTestFormParser).count
    parser = SecQuery::FilingParser.new(filing)
    expect(ObjectSpace.each_object(SecTestFormParser).count)
      .to eq(test_parser_count + 1)
  end

  it '#parser_for constantizes and initializes new parser' do
    parser = SecQuery::FilingParser.new(filing)
    expect(parser.parser_for('test_form')).to be_a(SecTestFormParser)
  end
end
