function! radar#Radar(...)
  let l:bufferName = '[Radar]'
  let l:fileListWidth = 50

  if bufexists(l:bufferName)
    execute 'bwipeout! \' . l:bufferName . '\'
  endif

  execute 'noswapfile tabnew'
  execute 'leftabove vnew ' . l:bufferName
  execute 'vertical resize ' . l:fileListWidth

  let b:currentWorkingDirectory = getcwd()

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
    nnoremap <buffer> <CR> :call <SID>RadarSelectFile()<CR>
    call <SID>RadarSelectFile()
  endif
endfunction

function! s:RadarSelectFile()
  let l:fileListWidth           = 50
  let l:currentWorkingDirectory = b:currentWorkingDirectory
  let l:newCommit               = b:newCommit
  let l:oldCommit               = b:oldCommit

  let l:selectedFile = getline('.')

  " Disables diff mode for all windows in the current tab page.
  " If we don't do this, :only! will complain that the :Gvdiff
  " windows contain changes, even if they don't.
  diffoff!

  only!
  vnew
  execute 'edit! ' . l:currentWorkingDirectory . '/' . l:selectedFile

  execute 'Gvdiff ' . l:newCommit . ' ' . l:oldCommit

  normal! gg
  " Go forward to the next diff, then backwards to the previous one.
  " This guarantees that if there is a diff on the very first line,
  " the cursor will not accidentally end up on the second diff in the file.
  " Conversely, if the first diff is not on the first line, the cursor will
  " always end up at the beginning of that first diff.
  normal! ]c[c 
  normal! zz
  normal! <C-w>=
endfunction
