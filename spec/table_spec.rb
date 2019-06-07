require_relative '../game/table'

RSpec.describe 'Table' do
  test = 'test'

  it 'should have no errors' do
    row = TableRow.new(
      name: test,
      difficulty: test,
      att_total: test,
      att_used: test,
      hints_total: test,
      hints_used: test
    )

    Table.new(rows: [row] * 3)
    Table.new
  end
end
