defmodule Test do
  require RecordTranslator
  def main do
    RecordTranslator.extract(from: "sample/sample_record.hrl")
  end
end
