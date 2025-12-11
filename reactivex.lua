local function unify(name, current)
  -- Ensure slash and dot module names share the same table so operator modules
  -- that register against either spelling stay visible to consumers.
  local pkg = type(package) == "table" and package or { loaded = {} }
  pkg.loaded = type(pkg.loaded) == "table" and pkg.loaded or {}
  local slash = "reactivex/" .. name
  local dot = "reactivex." .. name
  local loaded = pkg.loaded[slash]
  if pkg.loaded[dot] and pkg.loaded[dot] ~= loaded then
    loaded = pkg.loaded[dot]
  end
  loaded = loaded or current
  if loaded then
    pkg.loaded[slash] = loaded
    pkg.loaded[dot] = loaded
  end
  -- If a real package table exists, reflect the updates there as well.
  if type(package) == "table" and package ~= pkg and type(package.loaded) == "table" then
    package.loaded[slash] = pkg.loaded[slash]
    package.loaded[dot] = pkg.loaded[dot]
  end
  return loaded
end

local util = require("reactivex/util")
local Subscription = require("reactivex/subscription")
local Observer = require("reactivex/observer")
local Observable = require("reactivex/observable")
local ImmediateScheduler = require("reactivex/schedulers/immediatescheduler")
local CooperativeScheduler = require("reactivex/schedulers/cooperativescheduler")
local TimeoutScheduler = require("reactivex/schedulers/timeoutscheduler")
local Subject = require("reactivex/subjects/subject")
local AsyncSubject = require("reactivex/subjects/asyncsubject")
local BehaviorSubject = require("reactivex/subjects/behaviorsubject")
local ReplaySubject = require("reactivex/subjects/replaysubject")

require("reactivex/operators")
require("reactivex/aliases")

Observable = unify("observable", Observable)
Observer = unify("observer", Observer)
Subscription = unify("subscription", Subscription)
util = unify("util", util)

return {
  util = util,
  Subscription = Subscription,
  Observer = Observer,
  Observable = Observable,
  ImmediateScheduler = ImmediateScheduler,
  CooperativeScheduler = CooperativeScheduler,
  TimeoutScheduler = TimeoutScheduler,
  Subject = Subject,
  AsyncSubject = AsyncSubject,
  BehaviorSubject = BehaviorSubject,
  ReplaySubject = ReplaySubject,
}
