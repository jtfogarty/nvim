### Install coc-explorer
Install coc-explorer
  - :CocInstall coc-explorer
      
### Changing Themes
1. Create an .vim file in the themes folder witht he name of the theme
  - :new
      - add
          - `autocmd vimenter * colorscheme gruvbox`
  - :w ~/.config/nvim/themes/gruvbox.vim
2. Edit Plugins.vim file and add the below under the `theme` comment
  - 
3. Edit the init.vim file and add line to call ~/.config/nvim/themes/gruvbox.vim
