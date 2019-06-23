local http = require("coro-http")
local function getFile(str)

	local extension = str:gsub("(.*/)(.*)", "%2")
	local result,data = http.request("GET",str)
	if result.code ~= 200 then return end 
	fs.writeFileSync("temp"..extension,data)
	return "temp"..extension
end

local heresy = "317509481518989312"
local degeneracyChan = "247887833531023370"

local function parseHeresy(m)

	coroutine.wrap(function() 
		if not m.member then return end
		local newMsg = {}
		local filename
		if m.attachments then
			fileName = getFile(m.attachments[1].url)
			newMsg.file = fileName
		end
		newMsg.content = m.content
		newMsg.content = newMsg.content.."\n\nPosted By: "..m.member.name
		local chan = m.guild:getChannel(degeneracyChan)
		chan:send(newMsg)
		if m.attachments then
			os.remove(fileName)
		end
		m:delete()
	end)()
end


local function heresyReact(react)
	
	local msg = react.message
	if msg.channel and msg.channel.id ~= degeneracyChan and react.emojiName == "heresy" and react.count == 2 then
		parseHeresy(msg)
	end
end

local function heresyReactUncache(chan,mid,hash,uid)
	local ref
	local msg = chan:getMessage(mid)
	if not msg then return end
	for re in msg.reactions:iter() do
		if re.emojiName == "heresy" then
			print("gota a ref")
			ref = re
			break
		end
	end
	if ref and msg.channel and chan.id ~= degeneracyChan and hash == heresy and ref.count == 2 then
		parseHeresy(msg)
	end
end

local function setHooks()
	local h1 = client:on("reactionAdd",heresyReact)
	local h2 = client:on("reactionAddUncached",heresyReactUncache)
	return h1,h2
end

if heresyHook or heresyHookUncache then
	client:removeListener("reactionAdd",heresyHook)
	client:removeListener("reactionAddUncached",heresyHookUncache)

	heresyHook,heresyHookUncache = setHooks()
else
	heresyHook,heresyHookUncache = setHooks()
end

