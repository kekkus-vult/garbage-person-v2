local function fizz( message, arguments )
	message:reply("Hello, world!") --respond to message
	message:delete() --delete invoking message
end



--[[
	syntax: <command name>,<description>,<callback>
	the callback gets two arguments: message and args

	message is the full message object(needed to reply and delete etc)

	arguments is everything after the invoking command so the arguments for
	
	!foo cats lol

	will be "cats lol"
]]--




addCommand("foo","a dummy command",fizz)