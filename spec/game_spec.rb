require_relative 'spec_helper'
require_relative '../dependency'

RSpec.describe Game do
  describe '#start' do
    it 'has no errors' do
      described_class.stub(:gets).and_return("Name\n", "HELL\n", "1111")
      described_class.start
    end
  end

  describe '#choose_difficulty' do
    it 'returns a difficulty level' do
      described_class.stub(:gets).and_return("easy\n")
      described_class.send(:choose_difficulty).should eq(1)
      described_class.stub(:gets).and_return("medium\n")
      described_class.send(:choose_difficulty).should eq(2)
      described_class.stub(:gets).and_return("hard\n")
      described_class.send(:choose_difficulty).should eq(3)
      described_class.stub(:gets).and_return("HELL\n")
      described_class.send(:choose_difficulty).should eq(4)
      described_class.stub(:gets).and_return("foobar\n", "HELL\n")
      described_class.send(:choose_difficulty).should eq(4)
    end
  end
end
