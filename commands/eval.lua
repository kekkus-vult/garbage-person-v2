local function eval(msg,args)

	if msg.author ~= client.owner then return end
	local env = getfenv()
	env.m = msg
	env.send = function(...)
		local t = {}
		for i = 1,select("#",...) do
			table.insert(t,tostring(select(i,...)))
		end
		msg:reply(table.concat(t,"\t"))
	end

	local fn,err = load(args,"Eval","t",env)
	if not fn then
		msg:reply("There was a syntax error: ```lua\n"..err.."```")
		return
	end

	local ret,err2 = pcall(fn)
	if not ret then
		msg:reply("There was a runtime error: ```lua\n"..err2.."```")
	end
end

addCommand("geval","Run lua code",eval)