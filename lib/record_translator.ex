## based on
## http://github.com/elixir-lang/elixir/blob/v1.0.5/lib/elixir/lib/record/extractor.ex
## http://github.com/elixir-lang/elixir/blob/v1.0.5/lib/elixir/lib/record.ex

defmodule RecordTranslator.Impl do
  require Record

  defmacro defmap(name, kv) do
    quote bind_quoted: [name: name, kv: kv] do
      fields = RecordTranslator.Impl.__fields__(:defmap, kv)
      defmacro(unquote(name)()) do
        Macro.escape RecordTranslator.Impl.__map__(:defmap, unquote(name), unquote(fields))
      end
    end
  end

  @doc false
  def __map__(type, key, fields) do
    case Keyword.get(fields, key) do
      nil -> Dict.put(%{}, key, nil)
      attrs when is_list attrs  ->
        tmp = Enum.reduce(attrs, %{},
        fn({para, val}, acc_map)
          when Record.is_record val ->
            Dict.put(acc_map, para, (__map__(type, para, fields))[para])
          ({para, val}, acc_map) ->
            Dict.put(acc_map, para, val)
        end)
        Dict.put(%{}, key, tmp)
    end
  end

  # Normalizes of record fields to have default values.
  @doc false
  def __fields__(type, fields) do
    :lists.map(fn
      {key, val} when is_atom(key) ->
        try do
          Macro.escape(val)
        rescue
          e in [ArgumentError] ->
            raise ArgumentError, "invalid value for record field #{key}, " <> Exception.message(e)
        else
          val -> {key, val}
        end
      key when is_atom(key) ->
        {key, nil}
      other ->
        raise ArgumentError, "#{type} fields must be atoms, got: #{inspect other}"
    end, fields)
  end
end

defmodule RecordTranslator do
  import RecordTranslator.Impl

  defmacro def_all_map(file_name) do
    quote bind_quoted: [file_name: file_name] do
      records = Record.extract_all(from: file_name)
      for {record_name, _} <- records do
        defmap record_name, records
      end
    end
  end
end


