require_relative 'spec_helper'
require_relative '../dependency'

RSpec.describe DataUtils do
  include described_class
  let(:path) {'rspec_test_data.yaml'}

  summary = {
    name: 'Rspec',
    difficulty: 'test',
    att_total: 1,
    att_used: 1,
    hints_total: 1,
    hints_used: 1
  }

  describe '#save' do
    before do
      File.new(path, 'a') unless File.exist?(path)
    end

    after do
      File.delete(path) if File.exist?(path)
    end

    it 'saves a Table object to exists file' do
      old_size = File.new(path).size
      save(summary, path)
      new_size = File.new(path).size
      expect(new_size).to be > old_size
    end

    it 'saves a Table object to a new file' do
      File.delete(path) if File.exist?(path)
      save(summary, path)
      expect(File.exist?(path)).to eq(true)
    end
  end

  describe '#load' do
    it 'loads a Table class object from file' do
      save(summary, path)
      expect(load(path).is_a?(Table)).to eq(true)
      File.delete(path)
    end
  end
end
