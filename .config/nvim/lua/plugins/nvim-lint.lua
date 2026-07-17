return {
  -- https://github.com/mfussenegger/nvim-lint
  'mfussenegger/nvim-lint',
  event = 'BufWritePost',
  config = function()
    -- Define a table of linters for each filetype (not extension).
    -- Additional linters can be found here: https://github.com/mfussenegger
    require('lint').linters_by_ft = {
      python = {
        'flake8',
        'pylint',
      }
    }

  -- Automatically run linters afgter saving. Use "InsertLeave" for more
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      -- Only run linter for the following extensions. Remove this to alway
      pattern = { "*.py", },
      callback = function()
        require("lint").try_lint()
      end,
    })
  end
}
