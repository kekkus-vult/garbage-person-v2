local json = require("json")
local fs = require("fs")

local reactDat = json.decode(fs.readFileSync("data/reactions.json","r"))

local reactions = {}

for catagory,dat in pairs(reactDat) do
	for _,trigger in pairs(dat.triggers) do
		local t = {}
		t.word = trigger
		t.ref = catagory
		table.insert(reactions,t)
	end
end


local function sortedKeys(tablein)

	local keys = {}
	for key in pairs(tablein) do
		table.insert(keys,key)
	end
	table.sort(keys,function(a,b) return a>b end)

	local i = 0
	local iter = function()
		i = i + 1
		if keys[i] == nil then
			return
		else
			return keys[i],tablein[keys[i]]
		end

	end

	return iter
end

local function onMessage(m)

	if m.author == client.user then return end

	local match = false
	local word = ""
	local ref = ""
	for _,v in sortedKeys(reactions) do
		if not string.match(m.content:lower(),"%f[%a]"..v.word.."%f[%A]") then goto continue end
		local max = #reactDat[v.ref].reactions
		local r = reactDat[v.ref].reactions[math.random(max)]
		if r.type ==  "custom" then
			m:addReaction(client:getEmoji(r.reaction))
		else
			m:addReaction(r.reaction)
		end
		::continue::
	end
end

if reactHook then
	client:removeListener("messageCreate",reactHook)
	reactHook = client:on("messageCreate",onMessage)
else
	reactHook = client:on("messageCreate",onMessage)
end

