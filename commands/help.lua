addCommand("help","Shows help text for a command.",function(msg,args)

	if args == "" then
		msg:reply("I need a command!")
		return
	end

	local cmd = args:match("%w+")

	if commands[cmd] then
		local rep = "```\n%s: %s\n```"
		msg:reply(rep:format(cmd,commands[cmd].help))
	else
		msg:reply("Could not find the command "..cmd)
	end
	msg:delete()
end)