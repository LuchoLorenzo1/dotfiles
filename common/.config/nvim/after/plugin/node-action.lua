local node_action_status_ok, actions = pcall(require, "node_action")
if not node_action_status_ok then
	return
end



actions.setup({
	["typescriptreact"] = {
		["attribute_value"] = actions.conceal_string(),
	}
})
