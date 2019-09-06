local http = require("coro-http")
local json = require("json")
local url = "https://bugs.mojang.com/rest/api/2/issue/%s"

local function isCommand(m)

	if m.content and m.content:sub(1,4) == "!MC-" then
		return true
	else
		return false
	end
end

local function getIssue(str)

	local ret = {}
	local num = str:match("MC%-[0-9]+")

	if not num then
		return {content="Couldn't find that issue, are you sure you typed it right?"}
	end
	print(url:format(num))
	local res,dat = http.request("GET",url:format(num))
	if res.code ~= 200 then
		return {content = "There was some kind of error getting that report(HTTP Error: "..res.code..")"}
	end
	dat = json.decode(dat)
	ret.embed = {}
	ret.embed.title = dat.key..": "..dat.fields.summary
	ret.embed.url = "https://bugs.mojang.com/browse/"..dat.key
	
	if dat.resolution then
		ret.embed.description = "**Status:** "..dat.fields.status.name.." | **Resolution**: "..dat.fields.resolution.name
	else
		ret.embed.description = "**Status:** "..dat.fields.status.name.." | **Votes:** "..dat.fields.votes.votes
	end

	ret.embed.footer = {}
	ret.embed.footer.text = "Created"
	ret.embed.timestamp = dat.fields.created

	return ret
end



local function messageCreate(m)

	if not isCommand(m) then return end
	m:reply(getIssue(m.content))
end

if issueHook then
	client:removeListener("messageCreate",issueHook)
	issueHook = client:on("messageCreate",messageCreate)
else
	issueHook = client:on("messageCreate",messageCreate)
end

commands["mcissue"] = {
	help = "This is a dummy command, use !MC-xxx for Minecraft issues.",
	callback = function(m) m:reply("Excuse me, I said this was a dummy command") end
}