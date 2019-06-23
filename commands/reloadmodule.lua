local function tryLoad(cmd,msg)
	local func,err = loadfile("modules/"..cmd)
	if not func then 
		msg:reply("There was a syntax error when loading the module "..cmd..", the error was: ```lua\n"..err.."\n```")
	else
		setfenv(func,getfenv(1))
		local func,err = pcall(func)
		if not func then
			msg:reply("There was a syntax error when running the module "..cmd..", the error was: ```lua\n"..err.."\n```")
		end
	end
end


local function reloadCmd(msg,args)

	local cmdName = args:match("%w+")
	local cmdList = io.popen('ls modules/')
	for command in cmdList:lines() do
		if command == cmdName..".lua" then
			tryLoad(command,msg)
			msg:reply("Reloaded module "..cmdName)
			msg:delete()
			return
		end
	end
	msg:reply("Could not find the module "..cmdName)
end

addCommand("reloadmodule","reloads a module",reloadCmd)