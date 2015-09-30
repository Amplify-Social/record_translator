## modifications of
## http://github.com/elixir-lang/elixir/blob/v1.0.5/lib/elixir/lib/record/extractor.ex
## http://github.com/elixir-lang/elixir/blob/v1.0.5/lib/elixir/lib/record.ex

defmodule RecordTranslator do
  require Record

  defmacro defmap(name, kv) do
    quote bind_quoted: [name: name, kv: kv] do
      fields = RecordTranslator.__fields__(:defmap, kv)
      defmacro(unquote(name)()) do
        Macro.escape RecordTranslator.__map__(:defmap, unquote(name), unquote(kv))
      end
    end
  end

  # Normalizes of record fields to have default values.
  @doc false
  def __map__(type, key, fields) do
    case Keyword.get(fields, key) do
      nil -> Dict.put(%{}, key, nil)
      val when is_list(val) -> Dict.put(%{}, key, Enum.into(val, %{}))
      val ->
        try do
          Macro.escape(val)
        rescue
          e in [ArgumentError] ->
            raise ArgumentError, "invalid value for record field #{key}, " <> Exception.message(e)
        else
          val -> Dict.put(%{}, key, val)
        end
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

