require "arxanas/init"

-- Symbols --
local plane = {}
local plane_metatable = {__index = plane}

local plane_manager = {}
local plane_manager_metatable = {__index = plane_manager}

-- Exports --
arxanas.planar = {}
arxanas.planar.plane = plane
arxanas.planar.plane_manager = plane_manager

-- Plane --

-- Construct a new plane.
--
--   plane_manager: The plane manager which owns this plane.
function plane.new(plane_manager)
  return setmetatable({
    _hotkeys = {},
    _plane_manager = plane_manager,
    _enabled = false,
  }, plane_metatable)
end

-- Add a hotkey which can be triggered while this plane is enabled. The hotkey
-- will switch back to the default plane by default; if you don't want this
-- behavior, use 'add_hotkey_no_switch' instead.
--
-- You can't add more than one function for a given hotkey.
--
--   mods: The modifier keys, as per 'hotkey.new'.
--   key: The key, as per 'hotkey.new'.
--   fn: The function to be called when the hotkey is pressed. It's given this
--       plane as the first argument.
function plane:add_hotkey(new_hotkey)
  assert(self ~= nil)

  self:add_hotkey_no_switch(hotkey.new(
    new_hotkey.mods,
    new_hotkey.key,
    function(plane)
      assert(plane ~= nil)

      new_hotkey.fn(plane)
      plane._plane_manager:switch_to_default_plane()
    end
  ))
end

-- Add a hotkey just like 'add_hotkey', but once the hotkey has triggered,
-- disable this plane. Usually, hotkeys will disable the mode, so this will be
-- the right choice in many cases.
function plane:add_hotkey_no_switch(new_hotkey)
  assert(self ~= nil)

  local hooked_hotkey = hotkey.new(new_hotkey.mods, new_hotkey.key, function()
    new_hotkey.fn(self)
  end)

  if self._enabled then
    hooked_hotkey:enable()

    if self.on_leave then
      self:on_leave()
    end
  end

  table.insert(self._hotkeys, hooked_hotkey)
end

-- Enable this plane and all its hotkeys, and also disable any other planes
-- belonging to the same plane_manager.
function plane:enable()
  assert(self ~= nil)

  if not self._enabled then
    fnutils.each(self._hotkeys, hotkey.enable)

    if self.on_enter then
      self:on_enter()
    end
  end

  self._enabled = true
end

-- Disable this plane and all its hotkeys.
function plane:disable()
  assert(self ~= nil)

  if self._enabled then
    fnutils.each(self._hotkeys, hotkey.disable)
  end

  self._enabled = false
end

-- Plane manager --

-- Construct the plane manager.
-- 
-- The plane manager keeps a list of planes. It has a 'default' plane, which it
-- will revert to when it doesn't have any other enabled plane. It can only
-- have one plane enabled at a time. Your 'global' hotkeys, or those which
-- should be active without a given mode enabled, should be attached to the
-- default plane.
--
-- The given mods + key are called the 'break key', which invoke the
-- currently-selected plane's 'on_break_key' method if it exists, and then
-- returns to the default plane. If the 'on_break_key' method is called and it
-- returns a falsey value, the break is cancelled, although this might be a bad
-- idea.
function plane_manager.new(plane_hotkey)
  local plane_manager = setmetatable({
    _default_plane = nil, -- Set this below.
    _planes = {},
  }, plane_manager_metatable)

  -- Since the plane takes a reference to its manager, we have to construct the
  -- manager first and then inject the default plane.
  local default_plane = plane.new(plane_manager)
  plane_manager._default_plane = default_plane
  default_plane:enable()
  table.insert(plane_manager._planes, default_plane)

  -- Break key.
  hotkey.bind(plane_hotkey.mods, plane_hotkey.key, function()
    plane_manager:switch_to_plane(default_plane)
  end)

  return plane_manager
end

-- Add a new disabled plane which is set to trigger from the default plane
-- when mods + key is pressed. Returns that plane.
function plane_manager:add_plane(plane_hotkey)
  assert(self ~= nil)

  local new_plane = plane.new(self)
  table.insert(self._planes, new_plane)

  self._default_plane:add_hotkey_no_switch(hotkey.new(
    plane_hotkey.mods,
    plane_hotkey.key,
    function()
      self:switch_to_plane(new_plane)
    end
  ))

  return new_plane
end

-- Get the default plane.
function plane_manager:get_default_plane()
  assert(self ~= nil)

  return self._default_plane
end

-- Switch to the given plane. Calls the 'on_leave' method of the current plane,
-- if it exists, and then disables that plane and enables the new plane and
-- calls its 'on_enter' method, if it exists. This happens even if we're
-- already on that plane.
--
--   plane: The plane object to switch to.
function plane_manager:switch_to_plane(new_plane)
  assert(self ~= nil)

  fnutils.each(self._planes, plane.disable)
  new_plane:enable()
end

-- Switch to the default plane.
function plane_manager:switch_to_default_plane()
  assert(self ~= nil)

  self:switch_to_plane(self._default_plane)
end
