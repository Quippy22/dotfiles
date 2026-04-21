local venv_path = vim.fn.getcwd() .. "/.venv"
if vim.fn.isdirectory(venv_path) == 1 then
	vim.env.VIRTUAL_ENV = venv_path
	vim.env.PATH = venv_path .. "/bin:" .. vim.env.PATH
end

vim.api.nvim_create_autocmd("DirChanged", {
	pattern = "*",
	callback = function()
		local venv = vim.fn.getcwd() .. "/.venv"
		if vim.fn.isdirectory(venv) == 1 then
			vim.env.VIRTUAL_ENV = venv
			vim.env.PATH = venv .. "/bin:" .. vim.env.PATH
		end
	end,
})

-- Shim for ft_to_lang (removed in Neovim 0.12)
if vim.treesitter.language and not vim.treesitter.language.ft_to_lang then
    vim.treesitter.language.ft_to_lang = function(ft)
        return vim.treesitter.language.get_lang(ft) or ft
    end
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")
