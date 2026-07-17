return {
  -- https://gitub.com/mfussenegger/nvim-dap-python
  'mfussenegger/nvim-dap-python',
  ft = 'python',
  dependencies = {
    -- https://github.com/mfussenegger/nvim-dap
    'mfussenegger/nvim-dap',
  },
  config = function ()
    -- Update the path passed to setup to point to your system or virtual environment
    require('dap-python').setup('Users/joeswanson/.pyenv/shims/python')
  end
}
