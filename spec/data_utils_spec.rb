require_relative 'spec_helper'
require_relative '../dependency'

RSpec.describe DataUtils do
  include described_class
  path = 'SEED.yaml'.freeze
  File.new(path, 'a').close unless File.exist?(path)

  summary = {
    name: 'Rspec',
    difficulty: 'test',
    att_total: 1,
    att_used: 1,
    hints_total: 1,
    hints_used: 1
  }

  describe '#save' do
    it 'saves a Table object to exists file' do
      old_size = File.new(path).size
      save(summary, path)
      new_size = File.new(path).size
      new_size.should be > old_size
    end

    it 'saves a Table object to a new file' do
      new_file = 'new_file.yaml'
      File.delete(new_file) if File.exist?(new_file)
      save(summary, new_file)
      File.exist?(new_file)
    end
  end

  describe '#load' do
    it 'loads a Table class object from file' do
      load(path).is_a?(Table) if File.exist?(path)
    end
  end
end
