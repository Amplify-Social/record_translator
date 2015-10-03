RecordTranslator
================

This library gets an *Erlang* record file and translate it to
the *Elixir* map structure.


## Usage


```elixir
# 'def_all_map(file_name)' macro defines all the functions from the Erlang record file.  
defmodule Test do
  require RecordTranslator
  RecordTranslator.def_all_map("test/sample/sample_record.hrl")
  def get_age_of_person do
    person_map = person()
    # %{person:
    #   %{address:
    #     %{city: :undefined, country: "Japan", prefecture: "Tokyo"},
    #     age: 25,
    #     name: "Tanaka"}}
    person_map[:person][:age]
    # 25
  end
end
```
