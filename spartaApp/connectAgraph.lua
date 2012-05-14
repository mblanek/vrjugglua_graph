require("Actions")
require("getScriptFilename")
require("TransparentGroup")
vrjLua.appendToModelSearchPath(getScriptFilename())
dofile(vrjLua.findInModelSearchPath([[..\graph\loadGraphFiles.lua]]))

g = Graph(
	{
		["one"] = GraphNode{position = {0,0,0},radius = .13};
		["two"] = GraphNode{position = {0,1,0},radius = .13};

	},
	{
		

	}
)

RelativeTo.World:addChild(g.osg.root)
local hoveredNode = nil
Actions.addFrameAction(
	function()
		local device = gadget.PositionInterface("VJWand")
		while true do
			local device_pos = device.position - osgnav.position
			local changed_this_time = false
			for _,node in ipairs(g.nodes) do
				local distance = (osg.Vec3d(unpack(node.position))-device_pos):length()
				if math.abs(distance) < (node.radius*2) then
					node:highlight(true)
					changed_this_time = true
					hoveredNode = node
					Actions.waitForRedraw()
				else
					node:highlight(false)
					Actions.waitForRedraw()
				end
			end
			if changed_this_time == false then
				hoveredNode = nil
			end
		end
	end
)
local tempXFORM = Transform{}


Actions.addFrameAction(function()
	local drawBtn = gadget.DigitalInterface("VJButton2")
	local device = gadget.PositionInterface("VJWand")
	while true do
		local pointOne = nil
		local pointTwo = nil
		repeat
			Actions.waitForRedraw()
		until drawBtn.justPressed
		pointOne = hoveredNode
		RelativeTo.World:addChild(tempXFORM)
		while drawBtn.pressed and pointOne ~= nil do 
			local device_pos = device.position - osgnav.position
			tempXFORM.Child[1] = CylinderFromHereToThere(osg.Vec3d(unpack(pointOne.position)), device_pos, pointOne.radius/3, {1,1,0,1}) 
			Actions.waitForRedraw()
		end
		RelativeTo.World:removeChild(tempXFORM)
		Actions.waitForRedraw()
		pointTwo = hoveredNode
		if pointTwo ~= nil and (pointOne.name ~= pointTwo.name) then
			print("adding edge")
			g:addEdges{
				DirectedEdge(pointOne.name, pointTwo.name,{color = {1,1,0,1},radius = pointOne.radius/3})
			}
		end
	end
end)	