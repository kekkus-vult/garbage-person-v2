local url = require("querystring")
local templates = {
	["rollsafe"] = "rollsafe",
	["aliens"] = "aag",
	["drake"] = "drake",
}

local function doURL(text)
	text = text:gsub(" ","_")
	:gsub("?","~q")
	:gsub("%%","~p")
	:gsub("#","~h")
	:gsub("/","~s")
	:gsub("\"","''")
	return url.urlencode(text)
end

local baseUrl = "https://memegen.link/%s/%s.jpg"

local function genMeme(msg,args)

	local template = msg.content:match("%w+")

	if args:find("%%0D") or args:find("%%0A") then msg:reply("Hey! Knock it off!!") return end

	if not args:find(",") then
		local bottom = doURL(args)
		if #bottom >= 255 then msg:reply("Thats too long") return end
		local reply = {}
		reply.image = {}
		reply.image.url = baseUrl:format(templates[template],"_/"..args)
		msg:reply({embed = reply})
		msg:delete()
	else
		local words = doURL(args)
		words = words:gsub("%%2C","/")
		if #words > 255 then msg:reply("Thats too long") return end
		local reply = {}
		reply.image = {}
		reply.image.url = baseUrl:format(templates[template],words)
		msg:reply({embed = reply})
		msg:delete()
	end

end

for name,_ in pairs(templates) do
	addCommand(name,"Generates a "..name.." meme. syntax is <top text>,<bottom text>",genMeme)
end