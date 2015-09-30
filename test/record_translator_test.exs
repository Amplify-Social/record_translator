defmodule RecordTranslatorTest do
  use ExUnit.Case
  require RecordTranslator

  records = Record.extract_all(from: "test/sample/sample_record.hrl")
  RecordTranslator.defmap :address, records
  RecordTranslator.defmap :person, records

  # test from root directory
  test "defmap" do
    %{address: %{city: :undefined, country: "Japan", prefecture: "Tokyo"}} = address()
    %{person: %{address: :undefined, age: :undefined, name: :undefined}} = person()
  end

end
