"""
" User config via:
"
" let g:radar_command_name = 'Radar'
"""

if exists('g:radar_command_name') ==# 0   ||   g:radar_command_name ==# ''
  let g:radar_command_name = 'Radar'
endif

" Dynamically create the Manhunt invocation command, unless an identically
" named command already exists.
if exists(':' . g:radar_command_name) ==# 0
  execute 'command! -nargs=* ' . g:radar_command_name . ' call radar#Radar(<f-args>)'
endif
