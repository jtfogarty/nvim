# Aider.nvim

A Neovim plugin for integrating with the Aider AI coding assistant.

## Features

- Open Aider in a new buffer
- Run Aider in the background
- Automatically manage context by adding/removing files as buffers are opened/closed
- Custom keybindings and utility functions

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim), add the following to your Neovim configuration:

```lua
{
  "jtfogarty/aider.nvim",
  config = function()
    require('aider').setup({
      auto_manage_context = true,
      default_bindings = true,
      python_env = "aider_activate &&"
    })
    -- (Additional keybindings and functions will be set up automatically)
  end,
}