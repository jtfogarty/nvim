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
    -- Debug function
    local function debug_print(message)
      print("Aider Debug: " .. message)
    end

    -- Wrap AiderOpen with debug statements
    local function DebugAiderOpen()
      debug_print("AiderOpen function called")
      local status, err = pcall(AiderOpen)
      if not status then
        debug_print("Error in AiderOpen: " .. tostring(err))
      else
        debug_print("AiderOpen completed successfully")
      end
    end

    vim.api.nvim_set_keymap('n', '<leader>oa', '<cmd>lua DebugAiderOpen()<cr>', {noremap = true, silent = false})
    vim.api.nvim_set_keymap('n', '<leader>ob', '<cmd>lua AiderBackground()<cr>', {noremap = true, silent = false})

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
