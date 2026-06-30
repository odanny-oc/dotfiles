vim.api.nvim_create_user_command('VimtexCompileCopyPDF', function()
    local main_file = vim.b.vimtex.tex
    local project_dir = vim.fn.fnamemodify(main_file, ':h')
    local dirs_file = project_dir .. '/directories.txt'

    if vim.fn.filereadable(dirs_file) == 0 then
        vim.notify('No directories.txt found in ' .. project_dir, vim.log.levels.ERROR)
        return
    end

    local dirs = {}
    for line in io.lines(dirs_file) do
        local trimmed = line:match('^%s*(.-)%s*$')
        if trimmed ~= '' and not trimmed:match('^#') then
            local expanded = vim.fn.expand(trimmed)
            if vim.fn.isdirectory(expanded) == 0 then
                vim.notify('Directory does not exist: ' .. expanded, vim.log.levels.ERROR)
            else
                table.insert(dirs, expanded)
            end
        end
    end

    if #dirs == 0 then
        vim.notify('No valid directories found', vim.log.levels.WARN)
        return
    end

    -- Derive the PDF path from vimtex's output directory
    local pdf_name = vim.fn.fnamemodify(main_file, ':t:r') .. '.pdf'
    local vimtex_out_dir = vim.b.vimtex.compiler.build_dir
    -- build_dir may be relative or absolute
    local pdf_src
    if vim.fn.fnamemodify(vimtex_out_dir, ':p') == vimtex_out_dir then
        pdf_src = vimtex_out_dir .. '/' .. pdf_name
    else
        pdf_src = project_dir .. '/' .. vimtex_out_dir .. '/' .. pdf_name
    end

    local function copy_to_dirs()
        if vim.fn.filereadable(pdf_src) == 0 then
            vim.notify('PDF not found: ' .. pdf_src, vim.log.levels.ERROR)
            return
        end
        for _, dest_dir in ipairs(dirs) do
            local dest = dest_dir .. '/' .. pdf_name
            local ok, err = vim.loop.fs_copyfile(pdf_src, dest)
            if ok then
                vim.cmd('echom "✓ Copied to ' .. dest_dir .. '"')
            else
                vim.notify('✗ Failed to copy to ' .. dest_dir .. ': ' .. (err or ''), vim.log.levels.ERROR)
            end
        end
    end

    -- Hook into vimtex's compile callback so we copy after compilation finishes
    vim.api.nvim_create_autocmd('User', {
        pattern = 'VimtexEventCompileSuccess',
        once = true,
        callback = function()
            copy_to_dirs()
        end,
    })

    -- Trigger normal vimtex compilation
    vim.cmd('VimtexCompile')

end, { desc = 'Compile with vimtex then copy PDF to directories' })
