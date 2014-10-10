"""
" User config via:
"
" let g:radar_command_name = 'Radar'
"""

if exists('g:radar_command_name') ==# 0   ||   g:radar_command_name ==# ''
  let g:radar_command_name = 'Radar'
endif

if exists(':' . g:radar_command_name) !=# 2
  execute 'command! -nargs=* ' . g:radar_command_name . ' call radar#Radar(<f-args>)'
endif
