-- require("getScriptFilename")
-- fn = getScriptFilename()
-- assert(fn, "Have to load this from file, not copy and paste, or we can't find our models!")
-- vrjLua.appendToModelSearchPath(fn)


ss = RelativeTo.World:getOrCreateStateSet()
function doLight1_5()

	local l3 = osg.Light()
	l3:setLightNum(3)
	l3:setAmbient(osg.Vec4(.1, .1, .1, 1.0))
	
	local ls3 = osg.LightSource()
	ls3:setLight(l3)
	ls3:setLocalStateSetModes(osg.StateAttribute.Values.ON)

	ss:setAssociatedModes(l3, osg.StateAttribute.Values.ON)
	
	RelativeTo.Room:addChild(
		ls3
	)
	l3:setPosition(osg.Vec4(-1.0, 0.0, 1.25, 1.0))
end
-- function doLight2()

	-- l2 = osg.Light()
	-- l2:setLightNum(1)
	-- l2:setAmbient(osg.Vec4(.8, .8, 0.6, .50))
	
	-- ls2 = osg.LightSource()
	-- ls2:setLight(l2)
	-- ls2:setLocalStateSetModes(osg.StateAttribute.Values.ON)

	-- ss:setAssociatedModes(l2, osg.StateAttribute.Values.ON)
	
	-- RelativeTo.Room:addChild(
		-- ls2
	-- )
	-- l2:setPosition(osg.Vec4(1.5, 2, 0, 1.0))
-- end



doLight1_5()
