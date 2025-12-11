local function cleanReactiveX()
  -- Reset cached modules to simulate a fresh process between test cases.
  for key in pairs(package.loaded) do
    if key:sub(1, 9) == "reactivex" then
      package.loaded[key] = nil
    end
  end

  package.loaded["operators"] = nil
  _G.Observable = nil
end

describe('operators shim paths', function()
  it('loads operators from the namespaced path', function()
    cleanReactiveX()

    local Observable = require("reactivex/observable")
    require("reactivex/operators")

    expect(type(Observable.map)).to.equal("function")
    expect(package.loaded["reactivex/operators"]).to.be.truthy()
  end)

  it('loads operators from the legacy root shim', function()
    cleanReactiveX()

    local Observable = require("reactivex/observable")
    require("operators")

    expect(type(Observable.map)).to.equal("function")
    expect(package.loaded["operators"]).to.be.truthy()
    expect(package.loaded["reactivex/operators"]).to.be.truthy()
  end)
end)
