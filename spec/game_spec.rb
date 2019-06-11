require_relative 'spec_helper'
require_relative '../dependency'

RSpec.describe Game do
  subject(:game) { described_class.new(name: 'Rspec', difficulty: 'Easy') }

  describe '.check' do
    it 'returns ++++' do
      expect(game.check(game.secret)).to eq('++++')
    end
  end

  describe '#use_hint' do
    it 'decrements hints and calls a hint method if hints > 0' do
      game.instance_variable_set(:@hints, 1)
      game.use_hint
      expect(game.hints).to eq(0)
    end

    it 'returns a message if no hints left' do
      game.instance_variable_set(:@hints, 0)
      expect(game.use_hint).to eq('You have no hints')
    end
  end
end

# describe '#start' do
#   it 'has no errors' do
#     described_class.stub(:gets).and_return("Name\n", "HELL\n", "1111\n")
#     described_class.start
#   end
# end

# describe '#choose_difficulty' do
#   it 'returns a difficulty level' do
#     described_class.stub(:gets).and_return("easy\n")
#     described_class.send(:choose_difficulty).should eq('Easy')
#     described_class.stub(:gets).and_return("medium\n")
#     described_class.send(:choose_difficulty).should eq('Medium')
#     described_class.stub(:gets).and_return("hard\n")
#     described_class.send(:choose_difficulty).should eq('Hard')
#     described_class.stub(:gets).and_return("HELL\n")
#     described_class.send(:choose_difficulty).should eq('HELL')
#     described_class.stub(:gets).and_return("wrong input\n", "HELL\n")
#     described_class.send(:choose_difficulty).should eq('HELL')
#   end

#   it 'closes' do
#     allow(described_class).to receive(:exit)
#     described_class.stub(:gets).and_return("exit\n")
#     expect(described_class).to receive(:close)
#     described_class.send(:choose_difficulty)
#   end
# end

# describe '#game_process' do
#   it 'returns a Game Over' do
#     expect { described_class.send(:game_process) }.to output("Game Over\n").to_stdout
#   end

#   it 'set win to true' do
#     described_class.instance_variable_set(:@win, false)
#     described_class.instance_variable_set(:@attempts, 1)
#     described_class.instance_variable_set(:@hints, 1)
#     described_class.instance_variable_set(:@secret, '1111')
#     described_class.stub(:gets).and_return("1111\n")
#     described_class.send(:game_process)
#     described_class.instance_variable_get(:@win).should be true
#   end

# it 'closes' do
#   # allow(described_class).to receive(:loop).and_yield
#   allow(described_class).to receive_message_chain(:gets, :chomp).and_return('exit')
#   described_class.instance_variable_set(:@attempts, 1)
#   expect(described_class).to receive(:close)
#   described_class.send(:game_process)
# end

# it 'calls a hint' do
#   allow(described_class).to receive(:use_hint)
#   described_class.instance_variable_set(:@attempts, 1)
#   described_class.stub(:gets).and_return("hint\n")
#   expect(described_class).to receive(:use_hint)
#   described_class.send(:game_process)
# end

# describe '#save_results' do
#   include DataUtils
#   it 'calls save method' do
#     described_class.instance_variable_set(:@name, 'Tester')
#     described_class.instance_variable_set(:@difficulty, 'Easy')
#     described_class.instance_variable_set(:@total_attempts, 1)
#     described_class.instance_variable_set(:@attempts, 1)
#     described_class.instance_variable_set(:@total_hints, 1)
#     described_class.instance_variable_set(:@hints, 1)
#     described_class.send(:save_results)
#     expect(described_class).to receive(save)
#   end
# end

# describe '#game_summary' do
#   described_class.instance_variable_set(:@attempts, 1)
#   described_class.instance_variable_set(:@hints, 1)
#   described_class.instance_variable_set(:@secret, '1111')

#   it 'puts a lose message' do
#     described_class.instance_variable_set(:@win, false)

#   end

#   it 'calls a save method' do
#   end
# end
