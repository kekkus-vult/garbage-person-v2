local triggers = {}

triggers["when i was"] = "a young boy"
triggers["my father"] = "took me into the city"
triggers["to see a marching band"] = "he said"
triggers["son when"] = "you grow up"
triggers["will you be"] = "the savior of the broken"


triggers["what does marsellus wallace look like%??"] = "what?"
triggers["what country are you from%??"] = "what?"
triggers["what ain'?t no country i'?ve ever heard of.? they speak english in what%??"] = "what?"
triggers["english mother ?fucker do you speak it[!?]?[!?]?"] = "yes! yes!"
triggers["then you know what i'?m sayin'?%??"] = "yes!"
triggers["describe what marsellus wallace looks like"] = "what"
triggers["say what again[!.]? say what again i dare you i double dare you mother ?fucker say what one more goddamn time!?"] = "he's black"
triggers["go on!?"] = "he's bald"
triggers["does he look like a bitch[!?]?[!?]?"] = "what?! **gunshot**"


local function setHook()
	return client:on("messageCreate",function(m)
		if m.author == client.user then return end
		if not m.content then return end
		for trigger,reply in pairs(triggers) do
			if m.content:lower():find("^"..trigger.."$") then
				return m:reply(reply)
			end
		end
	end)
end

if lyricHook then
	client:removeListener("messageCreate",lyricHook)
	lyricHook = setHook()
else
	lyricHook = setHook()
end