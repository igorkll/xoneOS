computer.setArchitecture("Lua 5.3")

local gpu = component.proxy(component.list("gpu")() or error("no GPU found", 2))
local screen = component.list("screen")() or error("no screen found", 2)
local rx, ry = gpu.getResolution()
gpu.bind(screen)
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
    screen = screen
}
xone.libs.xone = xone

function xone.require(name)
    if xone.libs[name] then return xone.libs[name] end
    error("library \"" .. name .. "\" not found", 2)
end

_OSVERSION = xone.version
require = xone.require

--------------------------------