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
    _G.DebugAiderOpen = function()
      debug_print("AiderOpen function called")
      local aider = require('aider')
      debug_print("Aider module loaded: " .. tostring(aider ~= nil))
      debug_print("Aider module type: " .. type(aider))
      if type(aider) == "table" then
        for k, v in pairs(aider) do
          debug_print("Aider module key: " .. k .. ", type: " .. type(v))
        end
      end
      if aider and type(aider.open) == "function" then
        local status, err = pcall(aider.open)
        if not status then
          debug_print("Error in AiderOpen: " .. tostring(err))
        else
          debug_print("AiderOpen completed successfully")
        end
      else
        debug_print("Error: aider.open is not a function")
        if aider and type(aider.setup) == "function" then
          debug_print("Attempting to call aider.setup()")
          aider.setup({})
          debug_print("Aider setup completed")
        end
      end
    end

    vim.api.nvim_set_keymap('n', '<leader>oa', '<cmd>lua DebugAiderOpen()<cr>', {noremap = true, silent = false})
    vim.api.nvim_set_keymap('n', '<leader>ob', '<cmd>lua require("aider").background()<cr>', {noremap = true, silent = false})

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
