-record(address, {
          country = <<"Japan">>    :: binary(),
          prefecture = <<"Tokyo">> :: binary(),
          city :: binary()}).

-record(person, {
          name :: binary(),
          age :: integer(),
          address :: #address{}}).


