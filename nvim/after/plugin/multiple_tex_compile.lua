vim.api.nvim_create_user_command('VimtexCompileMulti', function()
    -- Get the directory containing the main tex file
    local main_file = vim.b.vimtex.tex
    local project_dir = vim.fn.fnamemodify(main_file, ':h')
    local dirs_file = project_dir .. '/directories.txt'

    -- Check if directories.txt exists
    if vim.fn.filereadable(dirs_file) == 0 then
        vim.notify('No directories.txt found in ' .. project_dir, vim.log.levels.ERROR)
        return
    end

    -- Read the directories
    local dirs = {}
    for line in io.lines(dirs_file) do
        local trimmed = line:match('^%s*(.-)%s*$')  -- trim whitespace
        if trimmed ~= '' and not trimmed:match('^#') then  -- skip empty lines and comments
            -- Expand environment variables and ~
            local expanded = vim.fn.expand(trimmed)

            -- Check if directory exists
            if vim.fn.isdirectory(expanded) == 0 then
                vim.notify('Directory does not exist: ' .. expanded, vim.log.levels.ERROR)
            else
                table.insert(dirs, expanded)
            end
        end
    end

    if #dirs == 0 then
        vim.notify('No valid build directories found', vim.log.levels.WARN)
        return
    end

    local tex_file = vim.fn.expand('%:t')

    for _, build_dir in ipairs(dirs) do
        vim.notify('Starting compilation to ' .. build_dir, vim.log.levels.INFO)

        vim.fn.jobstart(
            {'latexmk', '-pdf', '-output-directory=' .. build_dir, tex_file},
            {
                cwd = project_dir,
                on_exit = function(_, exit_code)
                    if exit_code == 0 then
                        vim.cmd('echom "✓ Compiled to ' .. build_dir .. '"')
                    else
                        vim.notify('✗ ' .. build_dir .. ' (exit ' .. exit_code .. ')', vim.log.levels.ERROR)
                    end
                end
            }
        )
    end
end, { desc = 'Compile to multiple directories asynchronously' })
