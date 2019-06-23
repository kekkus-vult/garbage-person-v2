local url = require("querystring")
local http = require("coro-http")
local json = require("json")

local f = io.open("data/dictkey.txt")
local apikey = f:read("*a")
f:close()

local dicturl = "http://dictionaryapi.com/api/v3/references/collegiate/json/%s?key=%s"

local function dict(m,args)

	local query = url.urlencode(args)
	if string.find(query,"%%0D") or string.find(query,"%%0A") then return m:reply("please don't") end

	coroutine.wrap(function()

		local url = dicturl:format(query,apikey)
		local res,body = http.request("GET",url,{},"")

		if #body == 2 then 
			print(url)
			for k,v in pairs(res) do
				print(k,v)
			end
			return m:reply("That's probably not a word.") 
		end

		local rep = {}
		body = json.decode(body)
		rep.title = m.content:sub(9)

		if not body[2].fl then return m:reply("Uh, what?") end

		local desc = m.content:sub(9).."("..body[2]['fl'].."):\n"
		for k,v in pairs(body[1]['shortdef']) do
			desc = desc..k..": "..v.."\n\n"
		end

		rep.description = desc
		
		m:reply({embed = rep})
	end)()
end

addCommand("define","Grabs a definition from the dictionary",dict)