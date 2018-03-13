if !has('python')
    echo "Error: Require vim compiled with +python"
    finish
endif

if !exists('g:impin_eng')
    finish
 endif

let g:impin_select = expand('<sfile>:p:h') . "/../im-select"

function! SaveIM()
python << EOF
import os
import vim
from subprocess import check_output

vim.vars["im"] = check_output(vim.vars["impin_select"])
check_output([vim.vars["impin_select"], vim.vars["impin_eng"]])
EOF
endfunction

function! StoreIM()
python << EOF
import vim
from subprocess import check_output

saved_im = vim.vars.get("im", None)
if saved_im:
    check_output([vim.vars["impin_select"], saved_im])
EOF
endfunction

autocmd InsertEnter * call StoreIM()
autocmd InsertLeave * call SaveIM()
