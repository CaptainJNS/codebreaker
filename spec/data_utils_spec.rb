require_relative 'spec_helper'
require_relative '../dependency'

RSpec.describe DataUtils do
  let(:dummy_class) { Class.new { extend DataUtils } }
  let(:path) { 'SEED.yaml' }

  let(:summary) do
    {
      name: 'Rspec',
      difficulty: 'Easy',
      att_total: 15,
      att_used: 1,
      hints_total: 3,
      hints_used: 1
    }
  end

  describe '#save' do
    it 'saves a TableRow object to a new file' do
      random_file = 'random_file_name.yaml'
      dummy_class.save(summary, random_file)
      expect(File.exist?(random_file)).to eq(true)
      File.delete(random_file)
    end

    it 'saves a TableRow object to exists file' do
      old_size = File.new(path).size
      dummy_class.save(summary, path)
      new_size = File.new(path).size
      expect(new_size).to be > old_size
    end
  end

  describe '#load' do
    it 'loads a TableRow object array from file' do
      dummy_class.save(summary, path)
      expect(dummy_class.load(path)[0].is_a?(TableRow)).to eq(true)
    end
  end
end
