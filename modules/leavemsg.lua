local guild = "217820359750057985"
local leaveMsg = "%s(%s/%s) had information that would lead to the arrest of Hillary Clinton, they are no longer with us."
local function memberLeft(mem)

	local g = client:getGuild(guild)

	g:getChannel("217820359750057985"):send(s:format(mem.mentionString,mem.user.name,(mem.nickname and mem.nickname or mem.name)))
end

if leaveHook then
	client:removeListener("memberLeave",leaveHook)
	leaveHook = client:on("memberLeave",memberLeft)
else
	leaveHook = client:on("memberLeave",memberLeft)
end  