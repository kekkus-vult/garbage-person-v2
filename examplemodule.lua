--"modules" are for basically anything that aren't commands. This is usually for event listeners of various types.

local function reactGay(message)
	if message.content:find("gay") then --real lazy way of finding gay in a post someone makes.
		message:addReaction("🏳️‍🌈") --This will add the reaction to the message.
	end
end

if reactGayHook then --because of the way hooks are set and the way we reload modules, this makes sure there's not more than one of the same hook running.
	client:removeListener("messageCreate",reactGayHook)
	reactGayHook = client:on("messageCreate",reactGay) --this runs every time a message is sent
else
	reactGayHook = client:on("messageCreate",reactGay)
end