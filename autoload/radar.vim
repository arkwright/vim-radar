function! radar#Radar(...)
  let l:bufferName = '[Radar]'
  let l:fileListWidth = 50

  if bufexists(l:bufferName)
    execute 'bwipeout! \' . l:bufferName . '\'
  endif

  execute 'noswapfile tabnew'
  execute 'leftabove vnew ' . l:bufferName
  execute 'vertical resize ' . l:fileListWidth

  if a:0 ==# 0
    let b:newCommit = ''
    let b:oldCommit = ''
  elseif a:0 ==# 1
    let b:newCommit = ''
    let b:oldCommit = a:1
  else
    let b:newCommit = a:1
    let b:oldCommit = a:2
  endif

  " Empty buffer if already full.
  execute '%d'

  execute 'silent! read !git diff --name-only ' . b:newCommit . ' ' . b:oldCommit

  normal! gg
  normal! dd

  setlocal buftype=nofile

  if getline('.') ==# ''
    call append(0, ['No files have changed.'])
    normal! G
    normal! dd
    normal gg
  else
    nnoremap <CR> :call <SID>RadarSelectFile()<CR>
    call <SID>RadarSelectFile()
  endif
endfunction

function! s:RadarSelectFile()
  let l:fileListWidth = 50
  let l:newCommit = b:newCommit
  let l:oldCommit = b:oldCommit

  let l:selectedFile = getline('.')

  " Disables diff mode for all windows in the current tab page.
  " If we don't do this, :only! will complain that the :Gvdiff
  " windows contain changes, even if they don't.
  diffoff!

  only!
  vnew
  execute 'edit! ' . l:selectedFile

  execute 'Gvdiff ' . l:newCommit . ' ' . l:oldCommit

  normal! gg
  normal! ]c
  normal! zz

  execute 'vertical resize ' . l:fileListWidth
endfunction
