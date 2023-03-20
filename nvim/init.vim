if exists('g:vscode')
    " VSCode extension
    set ignorecase " do case insensitive search
    set incsearch
    function! s:manageEditorSize(...)
        let count = a:1
        let to = a:2
        for i in range(1, count ? count : 1)
            call VSCodeNotify(to ==# 'increase' ? 'workbench.action.increaseViewSize' : 'workbench.action.decreaseViewSize')
        endfor
    endfunction

    " Sample keybindings. Note these override default keybindings mentioned above.
    nnoremap <C-w>> <Cmd>call <SID>manageEditorSize(v:count, 'increase')<CR>
    xnoremap <C-w>> <Cmd>call <SID>manageEditorSize(v:count, 'increase')<CR>
    nnoremap <C-w>+ <Cmd>call <SID>manageEditorSize(v:count, 'increase')<CR>
    xnoremap <C-w>+ <Cmd>call <SID>manageEditorSize(v:count, 'increase')<CR>
    nnoremap <C-w>< <Cmd>call <SID>manageEditorSize(v:count, 'decrease')<CR>
    xnoremap <C-w>< <Cmd>call <SID>manageEditorSize(v:count, 'decrease')<CR>
    nnoremap <C-w>- <Cmd>call <SID>manageEditorSize(v:count, 'decrease')<CR>
    xnoremap <C-w>- <Cmd>call <SID>manageEditorSize(v:count, 'decrease')<CR>
else
    " ordinary Neovim
    syntax on      " syntax highlighting
    set hlsearch   " highlight all search results
    set ignorecase " do case insensitive search
    set incsearch  " show incremental search results as you type
    set number     " display line numbers
    set noswapfile " disable swap file
    let mapleader = "'"
    inoremap jk <ESC>
endif