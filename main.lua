discordia = require("discordia")-- all of the discord api
fs = require("fs")-- fs.readFileSync, fs.writeFileSync

client = discordia.Client()-- the main client container for discordia

key = fs.readFileSync("key.txt","r")-- retrieve the key for the bot

commandPrefix = "!"

commands = {}

function addCommand(name,helpText,func)-- function to add a command, all commands need this!
	commands[name] = {-- add our command to the master command table
		help = helpText,
		callback = function(msg)
			local _,args = msg.content:match("(%w+) (.*)")-- split the prefix from the message and return only the resulting string
			func(msg,args or "")-- run out callback
		end
	}
	print("Added command "..name)
	
end



local cmdList = io.popen("ls commands/")-- get a list of all files in commands/

for script in cmdList:lines() do -- iterate over list and load each script
	local func,err = loadfile("commands/"..script)-- check for syntax errors
	if not func then 
		print("There was a syntax error when loading the command "..script..", the error was "..err)
	else
		setfenv(func,getfenv(1))
		local func,err = pcall(func)-- check for runtime errors
		if not func then
			print("There was an error when running the command "..script..", the error was "..err)
		end
	end
end
cmdList:close()

local function parseMessage(msg)-- our main command loop
	local triggerWord = msg.content:match("^!%w+")-- get the first word of a message
	if triggerWord then
		triggerWord = triggerWord:gsub("!","")
	else
		return
	end

	if commands[triggerWord] and msg.author ~= client.user then-- check if that first word is a command
		commands[triggerWord].callback(msg)-- run the command
	end
end

client:on("messageCreate",parseMessage)


local modules = io.popen("ls modules/")-- get a list of all files in commands/

for script in modules:lines() do -- iterate over list and load each script
	local func,err = loadfile("modules/"..script)-- check for syntax errors
	if not func then 
		print("There was a syntax error when loading the file "..script..", the error was "..err)
	else
		setfenv(func,getfenv(1))
		local func,err = pcall(func)-- check for runtime errors
		if not func then
			print("There was an error when running the file "..script..", the error was "..err)
		end
	end
end
modules:close()
print("modules loaded\n")


client:run("Bot "..key)