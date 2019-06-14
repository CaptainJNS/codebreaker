require_relative 'spec_helper'
require_relative '../dependency'

RSpec.describe DataUtils do
  include described_class
  let(:path) { 'rspec_test_data.yaml' }

  summary = {
    name: 'Rspec',
    difficulty: 'Easy',
    att_total: 1,
    att_used: 1,
    hints_total: 1,
    hints_used: 1
  }

  describe '#save' do
    it 'saves a TableRow object to a new file' do
      File.new(path, 'a') unless File.exist?(path)
      File.delete(path) if File.exist?(path)
      save(summary, path)
      expect(File.exist?(path)).to eq(true)
    end

    it 'saves a TableRow object to exists file' do
      old_size = File.new(path).size
      save(summary, path)
      new_size = File.new(path).size
      expect(new_size).to be > old_size
      File.delete(path) if File.exist?(path)
    end
  end

  describe '#load' do
    it 'loads a TableRow object array from file' do
      save(summary, path)
      expect(load(path)[0].is_a?(TableRow)).to eq(true)
      File.delete(path)
    end
  end
end
