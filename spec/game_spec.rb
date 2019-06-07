require_relative 'spec_helper'
require_relative '../dependency'

RSpec.describe Game do
  describe '#start' do
    it 'has no errors' do
      described_class.stub(:gets).and_return("Name\n", "HELL\n", "1111\n")
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

  describe '#game_process' do
    it 'returns a Game Over' do
      #described_class.attempts = 0
      described_class.stub(:gets).and_return("1111\n")
      expect { described_class.send(:game_process) }.to output("Game Over\n").to_stdout
    end
  end

  describe '#check' do
    it 'returns an error message' do
      described_class.send(:check, 'foobar').should eq('You have passed unexpected command or incorrect number.')
    end
  end
end
