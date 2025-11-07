local sonarlintPath = ""
local function getExtensionPath()
	if sonarlintPath then
		return sonarlintPath
	end
	sonarlintPath = vim.fn.stdpath("data") .. "/mason/packages/sonarlint-language-server/extension"
	return sonarlintPath
end

return {
	'iamkarasik/sonarqube.nvim',
	opts = {
		lsp = {
			cmd = {
            vim.fn.exepath("java"),
            "-jar",
            getExtensionPath() .. "/server/sonarlint-ls.jar",
            "-stdio",
            "-analyzers",
            getExtensionPath() .. "/analyzers/sonargo.jar",
            getExtensionPath() .. "/analyzers/sonarhtml.jar",
            getExtensionPath() .. "/analyzers/sonariac.jar",
            getExtensionPath() .. "/analyzers/sonarjava.jar",
            getExtensionPath() .. "/analyzers/sonarjavasymbolicexecution.jar",
            getExtensionPath() .. "/analyzers/sonarjs.jar",
            getExtensionPath() .. "/analyzers/sonarphp.jar",
            getExtensionPath() .. "/analyzers/sonarpython.jar",
            getExtensionPath() .. "/analyzers/sonartext.jar",
            getExtensionPath() .. "/analyzers/sonarxml.jar",
        },
			go = {
				enabled = true
			},
			-- typescript = {
			-- 	enabled = true
			-- },
			javascript = {
				enabled = true,
				clientNodePath = vim.fn.exepath("node")
			},
		}
	},
	cmd = {
		'SonarQubeInstallLsp',
		'SonarQubeShowConfig',
		'SonarQubeListAllRules',
	},
}
