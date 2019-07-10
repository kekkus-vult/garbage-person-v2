local function tryLoad(cmd,msg)
	local func,err = loadfile("commands/"..cmd)
	if not func then 
		msg:reply("There was a syntax error when loading the command "..cmd..", the error was: ```lua\n"..err.."\n```")
	else
		setfenv(func,getfenv(1))
		local func,err = pcall(func)
		if not func then
			msg:reply("There was a syntax error when running the command "..cmd..", the error was: ```lua\n"..err.."\n```")
		end
	end
end


local function reloadCmd(msg,args)

	local cmdName = args:match("%w+")
	local cmdList = io.popen("ls commands/")
	for command in cmdList:lines() do
		if command == cmdName..".lua" then
			tryLoad(command,msg)
			msg:reply("Reloaded command "..cmdName)
			msg:delete()
			return
		end
	end
	msg:reply("Could not find the command "..cmdName)
end

addCommand("reloadcommand","reloads a command",reloadCmd)