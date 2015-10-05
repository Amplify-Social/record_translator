-record(address, {
        country = <<"Japan">>    :: binary(),
        prefecture = <<"Tokyo">> :: binary(),
        city :: binary()}).

-record(person, {
        name = <<"Yamada Taro">> :: binary(),
        age  = 25 :: integer(),
        address = #address{} :: #address{}}).

-record(team, {
        name :: binary(),
        people = [#person{}] :: [#person{}]}).

