local url = require("querystring")
local http = require("coro-http")
local json = require("json")

local urbanurl = "https://api.urbandictionary.com/v0/define?term=%s"


local function urban (m,args) 
	local query = url.urlencode(args)

	if string.find(query,"%%0D") or string.find(query,"%%0A") then return m:reply("please don't") end

	coroutine.wrap(function()

		local url = urbanurl:format(query)
		local res,body = http.request("GET",url)

		if #body == 0 or #body == 11 then 
			return m:reply("That's probably not a thing.") 
		end

		local rep = {}
		body = json.decode(body)

		rep.title = body['list'][1].word
		rep.description = body['list'][1].word..": \n"..body['list'][1].definition.."\n\n Example:\n *"..body['list'][1].example.."*"

		m:reply({embed = rep})
	end)()
end

addCommand("urban","Gets a definition from urban dictionary.",urban)