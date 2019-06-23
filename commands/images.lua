local json = require('json')-- json.encode, json.decode

local images = json.decode(fs.readFileSync("data/images.json"))

for name,dat in pairs(images) do

	addCommand(name,"post a random "..name.." image.",function(msg)
		local max = #dat.reactions
		local reply = {image = {}}
		reply.image.url = dat.reactions[math.random(max)]
		msg:reply({embed = reply})
		msg:delete()
	end)
end