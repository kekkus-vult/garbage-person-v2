local guild = "217820359750057985"
local halal = "246099123655278593"
local haram = "246099154017714178"

local function vote(msg,args)
	if args == "" then msg:reply("I need something to ask!") return end
	local g = client:getGuild(guild)
	local yes = g:getEmoji(halal)
	local no = g:getEmoji(haram)

	local m = msg:reply(args)
	m:addReaction(yes)
	m:addReaction(no)
end

addCommand("poll","Create a poll about something.",vote)
addCommand("vote","Create a vote about something.",vote)
