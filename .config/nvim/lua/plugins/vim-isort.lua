return {
  -- removing this one because it conflicts with john's opinions on some packages
  -- -- https://github.com/fisadev/vim-isort
  -- 'fisadev/vim-isort',
  -- ft = 'python',
  -- config = function()
  --   -- Disable default key binding
  --   vim.g.vim_isort_map = ''
  --   vim.g.vim_isort_config_overrides = {
  --     force_sort_within_sections = true,
  --   }

  --   -- Automatically format file buffer when saving
  --   vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  --     pattern = "*.py",
  --     callback = function()
  --       vim.cmd("Isort")
  --     end,
  --   })
  -- end
}
