local pinChannel = "481333295226028034"

local function isImg(str)
	if str:find(".jpg") then return true end
	if str:find(".jpeg") then return true end
	if str:find(".png") then return true end
	if str:find(".gif") then return true end
	return false
end

local function doPin(msg,person)

	if not msg.member then return end
	if not person then return end

	local reply = {}

	reply.author = {}
	reply.author.name = msg.member.name
	reply.color = msg.member:getColor().value
	reply.description = msg.content

	if msg.attachment then
		if isImg(msg.attachment.filename) then
			reply.image = {}
			reply.image.url = msg.attachment.url
		else
			reply.description = reply.description.."\n\nAttachments: "..msg.attachment.url
		end
	end

	reply.footer = {}
	reply.footer.text = "Pinned by "..person.name..", sent"
	reply.timestamp = msg.timestamp
	return reply
end

local function react(reaction,user)

	local person
	local msg = reaction.message
	if msg.channel.id ~= pinChannel and reaction.emojiName == "📌" and reaction.count <= 1 then
		person = msg.guild:getMember(user)
		local channel = msg.guild:getChannel(pinChannel)
		local reply = doPin(msg,person)
		if not reply then return end
		channel:send({embed = reply, content = msg.link})
	end
end

local function reactUncache(chan,mid,hash,uid)

	local ref
	local msg = chan:getMessage(mid)
	if not msg then return end
	for re in msg.reactions:iter() do
		if re.emojiName == '📌' then
			ref = re
			break
		end
	end

	if msg.channel.id ~= pinChannel and hash == '📌' and ref.count <= 1 then
		react(ref,uid)
	end
end


local function setHooks()
	local h1 = client:on("reactionAdd",react)
	local h2 = client:on("reactionAddUncached",reactUncache)

	return h1,h2
end


if reactHook or reactHookUncache then
	client:removeListener("reactionAdd",reactHook)
	client:removeListener("reactionAddUncached",reactHookUncache)
	reactHook,reactHookUncache = setHooks()
else
	reactHook,reactHookUncache = setHooks()
end
