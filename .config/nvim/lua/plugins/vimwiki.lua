return {
  'vimwiki/vimwiki',
  init = function ()
    -- autocmd!
    -- automatically update links on read diary
    -- autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
    vim.api.nvim_create_autocmd({"BufEnter","BufNewFile","BufRead"}, {
      pattern = {"diary.wiki"},
      callback = function()
        vim.notify(string.format(
          "diary autocmd fired: file=%s wiki_nr=%s",
          vim.fn.expand("%:p"),
          tostring(vim.b.vimwiki_wiki_nr)
        ))
        local ok, err = pcall(vim.cmd, "VimwikiDiaryGenerateLinks")
        if not ok then
          vim.notify("VimwikiDiaryGenerateLinks failed: " .. tostring(err), vim.log.levels.ERROR)
        end
      end,
    })
    vim.g.vimwiki_list = {
      {path = '~/vimwiki/work/'},
      {path = '~/vimwiki/gym/'},
    }
  end
}
