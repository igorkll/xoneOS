local gpu = component.proxy(component.list()() or error("no GPU found", 2))
local screen = component.list("screen")()
local rx, ry = gpu.getResolution()
gpu.bind(screen)
gpu.setBackground(0x000000)
gpu.setForeground(0xffffff)
gpu.fill(1, 1, rx, ry, " ")
component.invoke(screen, "turnOn")

--------------------------------

local xone = {}
xone.version = "xoneOS"

function xone.require(name)
    
end