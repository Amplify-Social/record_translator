-record(address, {
          country = <<"Japan">>    :: binary(),
          prefecture = <<"Tokyo">> :: binary(),
          city :: binary()}).

-record(person, {
          name = <<"Tanaka">> :: binary(),
          age  = 25 :: integer(),
          address = #address{} :: #address{}}).

