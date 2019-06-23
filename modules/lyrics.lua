local triggers = {}

triggers['when i was'] = 'a young boy'
triggers['my father'] = 'took me into the city'
triggers['to see a marching band'] = 'he said'
triggers['son when'] = 'you grow up'
triggers['will you be'] = 'the savior of the broken'


triggers['what does marsellus wallace look like'] = 'what?'
triggers['what country are you from'] = 'what?'
triggers['what aint no country ive ever heard of. they speak english in what?'] = 'what?'
triggers['english motherfucker do you speak it'] = 'yes! yes!'
triggers['then you know what im sayin'] = 'yes!'
triggers['describe what marsellus wallace looks like'] = 'what'
triggers['say what again. say what again i dare you i double dare you motherfucker say what one more goddamn time'] = 'hes black'
triggers['go on!'] = 'hes bald'
triggers['does he look like a bitch'] = 'what?! **gunshot**'


local function setHook()
	return client:on("messageCreate",function(m)
		if m.author == client.user then return end
		if triggers[string.lower(m.content)] then
			m:reply(triggers[string.lower(m.content)])
		end
	end)
end

if lyricHook then
	client:removeListener("messageCreate",lyricHook)
	lyricHook = setHook()
else
	lyricHook = setHook()
end