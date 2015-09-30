defmodule RecordTranslatorTest do
  use ExUnit.Case
  require RecordTranslator

  records = Record.extract_all(from: "test/sample/sample_record.hrl")
  RecordTranslator.defmap :address, records
  RecordTranslator.defmap :person, records

  # test from root directory
  test "defmap" do
    %{person:
      %{address:
        %{city: :undefined,
          country: "Japan",
          prefecture: "Tokyo"},
        age: 25,
        name: "Tanaka"}} = person()

    %{address:
      %{city: :undefined,
        country: "Japan",
        prefecture: "Tokyo"}} = address()
  end

end
