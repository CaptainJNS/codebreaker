require_relative 'spec_helper'
require_relative '../dependency'

RSpec.describe Console do
  before do
    allow(described_class).to receive(:loop).and_yield
  end

  describe '.rules' do
    it 'shows the rules' do
      expect { described_class.send(:rules) }.to output(I18n.t(:rules)).to_stdout
    end
  end

  describe '.stats' do
    it 'shows the rules' do
      expect { described_class.send(:stats) }.to output("THIS IS STATS\n").to_stdout
    end
  end

  describe '.start' do
    after do
      described_class.start
    end

    # it 'calls the game_registration method' do
    #   expect(described_class).to receive(:game_registration)
    # end

    it 'calls the game_process method' do
      described_class.stub(:gets).and_return("Name\n", "easy\n")
      expect(described_class).to receive(:game_process)
    end
  end

  describe '.close' do
    it 'says goodbye' do
      allow(described_class).to receive(:exit)
      expect { described_class.send(:close) }.to output(I18n.t(:goodbye)).to_stdout
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

  describe '.choose_difficulty' do
    it 'calls close method' do
      allow(described_class).to receive(:exit)
      described_class.stub(:gets).and_return("exit\n")
      expect(described_class).to receive(:close)
      described_class.choose_difficulty
    end

    it 'shows a message' do
      allow(STDOUT).to receive(:puts).with(anything)
      allow(described_class).to receive(:gets).and_return('wrong input')
      expect(STDOUT).to receive(:puts).with('There is no such difficulty. Please choose one from listed')
      described_class.choose_difficulty
    end

    it 'returns a correct difficulty level' do
      {
        'easy' => 'Easy',
        'medium' => 'Medium',
        'hard' => 'Hard',
        'HELL' => 'HELL'
      }.each_pair do |input, output|
        allow(described_class).to receive(:gets).and_return(input)
        expect(described_class.choose_difficulty).to eq(output)
      end
    end
  end

  describe '.choose_name' do
    it 'calls close method' do
      allow(described_class).to receive(:exit)
      described_class.stub(:gets).and_return("exit\n")
      expect(described_class).to receive(:close)
      described_class.choose_name
    end

    it 'shows a message' do
      allow(STDOUT).to receive(:puts).with(anything)
      allow(described_class).to receive(:gets).and_return('')
      expect(STDOUT).to receive(:puts).with('Choosen name is invalid. Please choose another one')
      described_class.choose_name
    end

    it 'returns a choosen name' do
      described_class.stub(:gets).and_return("Name\n")
      expect(described_class.choose_name).to eq('Name')
    end
  end

  describe '.game_registration' do
    it 'sets a @game variable' do
      described_class.stub(:gets).and_return("Name\n", "easy\n")
      described_class.game_registration
      expect(described_class.instance_variable_get(:@game).is_a?(Game)).to eq(true)
    end
  end

  describe '.game_process' do
    before do
      allow(described_class).to receive(:loop).and_yield
      described_class.instance_variable_set(:@game, Game.new(name: 'Rspec', difficulty: 'Easy'))
    end

    after do
      described_class.game_process
    end

    it 'calls close method' do
      allow(described_class).to receive(:exit)
      described_class.stub(:gets).and_return("exit\n")
      expect(described_class).to receive(:close)
    end

    # it 'shows a Game Over text' do
    #   allow(STDOUT).to receive(:puts).with(anything)
    #   expect(STDOUT).to receive(:puts).with('Game Over')
    #   described_class.instance_variable_set(:@game.attempts, 0)
    # end

    it 'calls a use_hint method from Game class' do
      described_class.stub(:gets).and_return("hint\n")
      expect(described_class.instance_variable_get(:@game)).to receive(:use_hint)
    end

    it 'shows a message' do
      allow(STDOUT).to receive(:puts).with(anything)
      allow(described_class).to receive(:gets).and_return('wrong input')
      expect(STDOUT).to receive(:puts).with('There is no such command or your number is invalid. You can try use hint or exit')
    end

    it 'calls a check method from Game class' do
      described_class.stub(:gets).and_return("1234\n")
      expect(described_class.instance_variable_get(:@game)).to receive(:check)
    end
  end

  describe '.game_summary' do
    before do
      described_class.instance_variable_set(:@game, Game.new(name: 'Rspec', difficulty: 'Easy'))
    end

    after do
      described_class.game_summary
    end

    it 'shows a lose message' do
      allow(STDOUT).to receive(:puts).with(anything)
      expect(STDOUT).to receive(:puts).with('Sorry, you lose. Maybe another time.')
    end

    # it 'shows a win message' do
    #   described_class.instance_variable_set(:@game.win, true)
    #   allow(STDOUT).to receive(:puts).with(anything)
    #   expect(STDOUT).to receive(:puts).with('Congratulations! You win!')
    # end

    # it 'calls save_results method' do
    #   described_class.instance_variable_set(:@game.win, true)
    #   described_class.stub(:gets).and_return("save\n")
    #   expect(described_class).to receive(:save_results)
    # end
  end

  # describe '.save_results' do
  #   it 'calls a save method from DataUtils' do
  #     described_class.instance_variable_set(:@game, Game.new(name: 'Rspec', difficulty: 'Easy'))
  #     expect(DataUtils).to receive(:save)
  #     described_class.save_results
  #   end
  # end
end
