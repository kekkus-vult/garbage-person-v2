local function eval(msg,args)

	if msg.author ~= client.owner then return end
	local env = getfenv()
	env.m = m
	env.send = function(...)
		local t = {}
		if #{...} == 0 then 
			t = {"nil"}
		else
			for k,v in pairs({...}) do
				table.insert(t,tostring(v))
			end
		end
		m:reply(table.concat(t,"\t"))
	end

	local fn,err = load(code,"Eval","t",env)
	if not fn then
		m:reply("There was a syntax error: ```lua\n"..err.."```")
		return
	end

	local ret,err2 = pcall(fn)
	if not ret then
		m:reply("There was a runtime error: ```lua\n"..err2.."```")
	end
end

addCommand("geval","Run lua code",eval)