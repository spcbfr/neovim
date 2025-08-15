-- [[ Basic Autocommands ]]

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
  desc = "Match the terminal background to neovim's",
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
    if not normal.bg then
      return
    end
    io.write(string.format('\027]11;#%06x\027\\', normal.bg))
  end,
})

vim.api.nvim_create_autocmd('UILeave', {
  desc = "Restore the original terminal background color",
  callback = function()
    io.write '\027]111\027\\'
  end,
})
