local appbinder = {}
local appbinder_metatable = {__index = appbinder}

function appbinder.new(mods, file_name)
    return setmetatable({mods = mods, file_name = file_name}, appbinder_metatable)
end

function appbinder:bind_apps(apps)
    --[[
    Takes a list of app-key pairs and actually does the binding.
    --]]
    for app, key in pairs(apps) do
        hotkey.bind(self.mods, key, function()
            application.launchorfocus(app)
        end)
    end
end

function appbinder:get_bindings()
    --[[
    Get the list of app-key pairs from the given file.
    --]]

    -- Create the file if it doesn't exist.
    io.open(self.file_name, "a"):close()

    local bindings = {}

    local f = assert(io.open(self.file_name, "r"))
    for line in f:lines() do
        app, key = line:match("([^ ]+) ([^ ]+)")
        bindings[app] = key
    end
    f:close()

    return bindings
end

function appbinder:write_bindings(bindings)
    local f = assert(io.open(self.file_name, "w"))
    for app, key in bindings do
        f:write(string.format("%s %s", app, key))
    end
    f:close()
end

function appbinder:update_from_file()
    --[[
    Reread the file and get the new bindings.
    --]]
    self:bind_apps(self:get_bindings())
end

function appbinder:add(app, key)
    --[[
    Add and persist a new binding.
    --]]
    bindings = self:get_bindings()

    bindings[app] = key
    hydra.alert(string.format("Bound app %s to H-%s", app, key))

    self:write_bindings(bindings)
    self:update_from_file()
end

ext.appbinder = {}
function ext.appbinder.new(mods, file_name)
    local appbinder = appbinder.new(mods, file_name)
    appbinder:update_from_file()
    return appbinder
end
