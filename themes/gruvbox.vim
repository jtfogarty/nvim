
if (has('termguicolors'))
  set termguicolors
else
  g:gruvbox_termcolors=512
endif

syntax enable
let g:gruvbox_contrast_dark='hard'
"let g:gruvbox_contrast_dark='soft'
autocmd vimenter * colorscheme gruvbox

