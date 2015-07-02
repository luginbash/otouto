local PLUGIN = {}

PLUGIN.doc = [[
	!help [command]
	Get list of basic information for all commands, or more detailed documentation on a specified command.
]]

PLUGIN.triggers = {
	'^!help',
	'^!h$'
}

function PLUGIN.action(msg)

	local input = get_input(msg.text)

	if input then
		for i,v in ipairs(plugins) do
			if v.doc then
				if '!' .. input == trim_string(first_word(v.doc)) then
					return send_msg(msg, v.doc)
				end
			end
		end
	end

	if msg.from.id ~= msg.chat.id then
		if not send_message(msg.from.id, help_message, true, msg.message_id) then
			return send_msg(msg, help_message) -- Unable to PM user who hasn't PM'd first.
		end
		return send_msg(msg, 'I have sent you the requested information in a private message.')
	else
		return send_msg(msg, help_message)
	end

end

return PLUGIN