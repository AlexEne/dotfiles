-- Mouse Battery: polls `solaar show` via the bundled helper and shows a
-- battery glyph in the bar. Hover for details, click to refresh.
-- Ported from the v4 (QML) mouse-battery plugin.

local dir    = noctalia.pluginDir() or "."
local SCRIPT = dir .. "/solaar_battery.py"

-- State
local percentage = nil -- number once known
local charging   = false
local mouseName  = "Mouse"
local lastError  = nil -- string while unhealthy
local refreshing = false

local function glyph()
    if lastError ~= nil then
        return "battery-off"
    end
    if charging then
        return "battery-charging"
    end
    local p = percentage or 0
    if p <= 10 then
        return "battery"
    elseif p <= 30 then
        return "battery-1"
    elseif p <= 50 then
        return "battery-2"
    elseif p <= 70 then
        return "battery-3"
    else
        return "battery-4"
    end
end

local function glyphColor()
    if lastError ~= nil then
        return "error"
    end
    if charging then
        return "primary"
    end
    local p = percentage or 100
    if p <= 10 then
        return "error"
    elseif p <= 20 then
        return "warning"
    end
    return "on_surface"
end

local function render()
    barWidget.setGlyph(glyph())
    barWidget.setGlyphColor(glyphColor())
    if lastError ~= nil then
        barWidget.setTooltip("Mouse battery: " .. lastError)
    else
        barWidget.setTooltip(string.format(
            "%s: %d%%%s",
            mouseName,
            percentage or 0,
            charging and " (Charging)" or ""
        ))
    end
end

local function refresh()
    if refreshing then
        return
    end
    if not noctalia.commandExists("python3") then
        lastError = "python3 not found"
        render()
        return
    end
    refreshing = true
    local accepted = noctalia.runAsync({ "python3", SCRIPT }, function(result)
        refreshing = false
        if result.timedOut then
            lastError = "solaar timed out"
        elseif result.exitCode ~= 0 then
            -- The helper prints {"error": "..."} and exits 1 on failure.
            local data = noctalia.json.decode(result.stdout or "")
            lastError = (data and data.error) or ("helper exited with code " .. tostring(result.exitCode))
        else
            local data, err = noctalia.json.decode(result.stdout)
            if data == nil then
                lastError = "bad response: " .. tostring(err)
            elseif data.error ~= nil then
                lastError = tostring(data.error)
            else
                percentage = tonumber(data.percentage) or 0
                charging   = data.charging == true
                mouseName  = tostring(data.name or "Mouse")
                lastError  = nil
            end
        end
        render()
    end)
    if not accepted then
        refreshing = false
        lastError = "failed to start helper"
        render()
    end
end

function update()
    local interval = tonumber(noctalia.getConfig("interval")) or 900
    noctalia.setUpdateInterval(interval * 1000)
    refresh()
end

function onClick()
    refresh()
end
