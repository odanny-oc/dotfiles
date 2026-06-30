-- ~/.config/nvim/after/ftplugin/tex.lua

local uv = vim.uv or vim.loop

local watcher = nil

local function read_dirs(build_dir)
  local f = io.open(build_dir .. "/directories.txt", "r")
  if not f then return {} end
  local dirs = {}
  for line in f:lines() do
    line = line:match("^%s*(.-)%s*$")
    if line ~= "" and not line:match("^#") then
      table.insert(dirs, vim.fn.expand(line))
    end
  end
  f:close()
  return dirs
end

local function distribute(pdf, dirs)
  local fname = vim.fn.fnamemodify(pdf, ":t")
  for _, dir in ipairs(dirs) do
    local dest = dir .. "/" .. fname
    if uv.fs_copyfile then
      local ok, err = uv.fs_copyfile(pdf, dest)
      if ok then
        vim.notify("[TexDist] → " .. dest, vim.log.levels.INFO)
      else
        vim.notify("[TexDist] failed → " .. dest .. ": " .. tostring(err), vim.log.levels.ERROR)
      end
    else
      local ret = os.execute(string.format("cp -- %q %q", pdf, dest))
      if ret == 0 then
        vim.notify("[TexDist] → " .. dest, vim.log.levels.INFO)
      else
        vim.notify("[TexDist] cp failed → " .. dest, vim.log.levels.ERROR)
      end
    end
  end
end

local function get_paths()
  local tex = vim.api.nvim_buf_get_name(0)
  local build_dir
  local ok, state = pcall(vim.fn["vimtex#state#get"])
  if ok and type(state) == "table" and state.out_dir and state.out_dir ~= "" then
    build_dir = state.out_dir
  else
    build_dir = vim.fn.fnamemodify(tex, ":h")
  end
  local pdf = build_dir .. "/" .. vim.fn.fnamemodify(tex, ":t:r") .. ".pdf"
  return pdf, build_dir
end

vim.api.nvim_create_user_command("TexDist", function()
  local pdf, build_dir = get_paths()

  vim.cmd("VimtexCompile")

  if watcher then watcher:stop() end
  watcher = uv.new_fs_event()
  local pdf_name = vim.fn.fnamemodify(pdf, ":t")
  local timer = nil

  watcher:start(vim.fn.fnamemodify(pdf, ":h"), { recursive = false },
    vim.schedule_wrap(function(err, filename, _)
      if err or filename ~= pdf_name then return end
      if timer then timer:stop() end
      timer = vim.defer_fn(function()
        timer = nil
        local dirs = read_dirs(build_dir)
        if #dirs > 0 then distribute(pdf, dirs) end
      end, 300)
    end))

  vim.notify("[TexDist] watching " .. pdf, vim.log.levels.INFO)
end, { desc = "VimTeX compile + distribute PDF on change" })

vim.api.nvim_create_user_command("TexDistStop", function()
  if watcher then
    watcher:stop()
    watcher = nil
    vim.notify("[TexDist] stopped", vim.log.levels.INFO)
  end
end, { desc = "Stop PDF distribution watcher" })
