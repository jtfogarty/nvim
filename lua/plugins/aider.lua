return {
  "jtfogarty/aider.nvim",
  config = function()
    require('aider').setup({
      -- Configuration options
      auto_manage_context = true,
      default_bindings = true,
      -- You can also set the model to use
      -- model = "claude 3.5", -- or "gpt-3.5-turbo" or any other available model
      python_env = "aider_activate &&"
    })

    -- Keybindings
    vim.api.nvim_set_keymap('n', '<leader>oa', '<cmd>lua require("aider").AiderOpen()<cr>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>ob', '<cmd>lua require("aider").AiderBackground()<cr>', {noremap = true, silent = false})

    -- Modify the AiderBackground function in the aider module
    local aider = require("aider")
    local original_background = aider.AiderBackground
    aider.AiderBackground = function()
        -- Ensure the aider directory exists
        local aider_dir = vim.fn.expand('~/.aider')
        if vim.fn.isdirectory(aider_dir) == 0 then
            vim.fn.mkdir(aider_dir, 'p')
        end

        -- Ensure the input and output files exist
        local input_file = aider_dir .. '/input.md'
        local output_file = aider_dir .. '/output.md'
        if vim.fn.filereadable(input_file) == 0 then
            vim.fn.writefile({}, input_file)
        end
        if vim.fn.filereadable(output_file) == 0 then
            vim.fn.writefile({}, output_file)
        end

        -- Open the input file in a new buffer
        vim.cmd('edit ' .. input_file)

        -- Call the original function
        local status, err = pcall(original_background)
        if not status then
            print("Error in AiderBackground: " .. tostring(err))
        end
    end

    -- ReloadBuffer function
    function _G.ReloadBuffer()
      local temp_sync_value = vim.g.aider_buffer_sync
      vim.g.aider_buffer_sync = 0
      vim.api.nvim_exec2('e!', {output = false})
      vim.g.aider_buffer_sync = temp_sync_value
    end
    vim.api.nvim_set_keymap('n', '<leader>rb', '<cmd>lua ReloadBuffer()<cr>', {noremap = true, silent = true})

    -- close_hidden_buffers function
    _G.close_hidden_buffers = function()
      -- ... (paste the function from the README here)
    end
    vim.api.nvim_set_keymap('n', '<leader>ch', '<cmd>lua close_hidden_buffers()<cr>', {noremap = true, silent = true})
  end,
}
