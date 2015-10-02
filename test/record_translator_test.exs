defmodule RecordTranslatorTest do
  use ExUnit.Case
  require RecordTranslator

  RecordTranslator.def_all_map("test/sample/sample_record.hrl")

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
