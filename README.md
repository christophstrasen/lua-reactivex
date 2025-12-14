# Lua-ReactiveX

[Reactive Extensions](http://reactivex.io) for Lua.

Lua-ReactiveX gives Lua the power of Observables: data structures that represent a stream of values over time. They're handy for events, streams of data, asynchronous requests, and concurrency-like composition.

This repo is a maintained fork of https://github.com/4O4/lua-reactivex (itself a fork of [RxLua](https://github.com/bjornbytes/RxLua)). Credits for the original work go to [bjornbytes](https://github.com/bjornbytes), with further stewardship and improvements by Paweł K (4O4) and contributors.

This fork adds familiar Rx operators like `publish`, `refCount`, and `share`.

More importantly, it includes compatibility changes so lua-reactivex runs in more restricted Lua environments (e.g. Project Zomboid's Kahlua runtime) while staying compatible with stock Lua. For example: `require` paths use slashes, folder modules avoid relying on `init.lua`, and optional/restricted packages like `io` are guarded with fallbacks.

## Getting Started

Simply clone the repo to get started. 

### Restricted environments (e.g. Project Zomboid / locked-down `package.path`)

If you vend `lua-reactivex` as a git submodule but your host runtime can only `require(...)` from a specific folder (and/or does not support `init.lua` folder loading), copy the Lua payload into that folder as siblings: `reactivex.lua`, the `reactivex/` directory, and `operators.lua` (root-level operator aggregator). With that layout, `local rx = require("reactivex")` works without needing any `package.path` changes, and `require("reactivex/operators")` resolves via the sibling `operators.lua`.

## Example Usage

Use ReactiveX to construct a simple cheer:

```lua
local rx = require("reactivex")

rx.Observable.fromRange(1, 8)
  :filter(function(x) return x % 2 == 0 end)
  :concat(rx.Observable.of('who do we appreciate'))
  :map(function(value) return value .. '!' end)
  :subscribe(print)

-- => 2! 4! 6! 8! who do we appreciate!
```

See [examples](examples) for more.

## Resources

- [Documentation](doc)
- [Contributor Guide](doc/CONTRIBUTING.md)
- [ReactiveX Introduction](http://reactivex.io/intro.html)

## Tests

Uses [lust](https://github.com/bjornbytes/lust). Run with:

```
lua tests/runner.lua
```

or, to run a specific test:

```
lua tests/runner.lua skipUntil
```

## License

[MIT](LICENSE)
