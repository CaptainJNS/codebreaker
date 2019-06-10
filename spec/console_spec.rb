require_relative 'spec_helper'
require_relative '../dependency'

RSpec.describe Console do
  before do
    allow(described_class).to receive(:loop).and_yield
  end

  describe '.rules' do
    it 'shows the rules' do
      expect { described_class.send(:rules) }.to output("THIS IS RULES\n").to_stdout
    end
  end

  describe '.start' do
    it 'calls the start method in Game class' do
      expect(Game).to receive(:start)
      described_class.start
    end
  end

  describe '.close' do
    it 'says goodbye' do
      allow(described_class).to receive(:exit)
      expect { described_class.send(:close) }.to output("Goodbye!\n").to_stdout
    end

    it 'closes' do
      expect(described_class).to receive(:exit)
      described_class.close
    end
  end

  describe '.run' do
    after do
      described_class.run
    end

    it 'calls start method' do
      described_class.stub(:gets).and_return("start\n")
      expect(described_class).to receive(:start)
    end

    it 'calls rules method' do
      described_class.stub(:gets).and_return("rules\n")
      expect(described_class).to receive(:rules)
    end

    it 'calls stats method' do
      described_class.stub(:gets).and_return("stats\n")
      expect(described_class).to receive(:stats)
    end

    it 'calls close method' do
      allow(described_class).to receive(:exit)
      described_class.stub(:gets).and_return("exit\n")
      expect(described_class).to receive(:close)
    end

    it 'shows a message' do
      allow(STDOUT).to receive(:puts).with(anything)
      allow(described_class).to receive(:gets).and_return('wrong input')
      expect(STDOUT).to receive(:puts).with('You have passed unexpected command. Please choose one from listed commands')
      described_class.send(:run)
    end
  end
end
