computer.setArchitecture("Lua 5.3")

local gpu = component.proxy(component.list("gpu")() or error("no GPU found", 2))
local screen = component.list("screen")() or error("no screen found", 2)
gpu.bind(screen)
gpu.setResolution(50, 16)
local rx, ry = gpu.getResolution()
gpu.setBackground(0x000000)
gpu.setForeground(0xffffff)
gpu.fill(1, 1, rx, ry, " ")
component.invoke(screen, "turnOn")

local component = component
local computer = computer
local unicode = unicode
_G.component = nil
_G.computer = nil
_G.unicode = nil

--------------------------------

local xone = {
    version = "xoneOS",
    libs = {
        component = component,
        computer = computer,
        unicode = unicode,
        math = math,
        table = table,
        string = string
    },
    gpu = gpu,
    screen = screen,
    rx = rx,
    ry = ry
}
xone.libs.xone = xone

function xone.round(number)
    if number >= 0 then
        return math.floor(number + 0.5)
    else
        return math.ceil(number - 0.5)
    end
end

function xone.map(value, low, high, low_2, high_2)
    local relative_value = (value - low) / (high - low)
    local scaled_value = low_2 + (high_2 - low_2) * relative_value
    return scaled_value
end

function xone.clamp(value, min, max)
    return math.min(math.max(value, min), max)
end

function xone.roundTo(number, numbers)
    numbers = numbers or 3
    return tonumber(string.format("%." .. tostring(math.floor(numbers)) .. "f", number))
end

function xone.require(name)
    if xone.libs[name] then return xone.libs[name] end
    error("library \"" .. name .. "\" not found", 2)
end

function xone.zone(sx, sy)
    local px, py = rx / 2, ry / 2
    px = px - math.floor(sx / 2)
    px = px - math.floor(sy / 2)
    return xone.round(px) + 1, xone.round(py) + 1
end

function xone.frame(px, py, sx, sy)
    if not sx then
        sx, sy = px, py
        px, py = xone.zone(sx, sy)
    end

    gpu.fill(px, py, sx, 1, "═")
    gpu.fill(px, py + (sy - 1), sx, 1, "═")
    gpu.fill(px, py, 1, sy, "║")
    gpu.fill(px + (sx - 1), py, 1, sy, "║")

    return px, py
end

_OSVERSION = xone.version
require = xone.require

--------------------------------

xone.frame(50, 16)
while true do
    computer.pullSignal()
end