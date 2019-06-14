class TableRow
  DIFFICULTY_HASH = {
    I18n.t(:easy) => 1,
    I18n.t(:medium) => 2,
    I18n.t(:hard) => 3,
    I18n.t(:hell) => 4
  }.freeze

  attr_accessor :name, :difficulty, :att_total, :att_used, :hints_total, :hints_used

  def initialize(name:, difficulty:, att_total:, att_used:, hints_total:, hints_used:)
    @name = name
    @difficulty = DIFFICULTY_HASH[difficulty]
    @att_total = att_total
    @att_used = att_used
    @hints_total = hints_total
    @hints_used = hints_used
  end

  def to_s
    I18n.t(:stats,
           name: @name,
           difficulty: @difficulty,
           att_total: @att_total,
           att_used: @att_used,
           hints_total: @hints_total,
           hints_used: @hints_used)
  end
end
