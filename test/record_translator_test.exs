defmodule RecordTranslatorTest do
  use ExUnit.Case
  require RecordTranslator

  RecordTranslator.def_all_map("test/sample/sample_record.hrl")

  # test from root directory
  test "def_all_map" do
    %{person:
        %{address:
        %{city: :undefined,
          country: "Japan",
          prefecture: "Tokyo"},
        age: 25,
        name: "Yamada Taro"}} = person()

    %{address:
      %{city: :undefined,
        country: "Japan",
        prefecture: "Tokyo"}} = address()

    %{team:
      %{name: :undefined,
        people: [
          %{person:
            %{address:
              %{city: :undefined,
                country: "Japan",
                prefecture: "Tokyo"},
              age: 25,
              name: "Yamada Taro"}}
        ]}} = team()
  end

end
