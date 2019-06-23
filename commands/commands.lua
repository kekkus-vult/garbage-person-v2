addCommand("commands","List all available commands.",function(msg)

	local reply = "Available commands are:\n ```"

	for name,dat in pairs(commands) do
		reply = reply.."!"..name.."\n"
	end
	msg:reply(reply.."```\n Use !help <command> for more info on a command.")
end)