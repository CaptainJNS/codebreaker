require_relative '../game/table'

RSpec.describe Table do
  test = 'test'

  it 'has no errors' do
    row = TableRow.new(
      name: test,
      difficulty: test,
      att_total: test,
      att_used: test,
      hints_total: test,
      hints_used: test
    )

    described_class.new(rows: [row] * 3)
    described_class.new
  end
end
