local function setHook()
	return client:on("messageCreate",function(m)
		if m.author.id == "134073775925886976" and m.embeds and m.embeds[1].title == "Do more with Wolfram|Alpha pro" then
			m:delete()
		end
	end)
end

if wolframHook then
	client:removeListener("messageCreate",wolframHook)
	wolframHook = setHook()
else
	wolframHook = setHook()
end
