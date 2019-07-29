local timer = require("timer")
local function setHook()

	return client:on("messageCreate",function(m)

		if m.channel and m.channel.id == "323309475438002176" then
			timer.sleep(600000)
			m:delete()
		end
	end)
end

if spoilerHook then
	client:removeListener("messageCreate",spoilerHook)
	spoilerHook = setHook()
else
	spoilerHook = setHook()
end