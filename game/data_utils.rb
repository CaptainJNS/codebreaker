module DataUtils
  SEED = 'SEED.yaml'.freeze

  def load(path = SEED)
    Psych.safe_load(
      File.read(path),
      [Symbol, Table, TableRow],
      [],
      true
    )
  end

  def save(summary, path = SEED)
    row = [TableRow.new(summary)]
    if File.exist?(path)
      data = load(path)
      data.rows.push(row)
    else
      data = Table.new(rows: [row])
    end
    File.write(path, data.to_yaml)
  end
end
