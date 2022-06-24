# Description

This plugin counts the number of wide characters and the number of ASCII words.

# Installation

Via your favorite plugin manager.

# Functions

- `CountCEWords()`: count words in non-LaTeX buffers; should be called with range
- `CountTexCEWords()`: count words in LaTeX buffers; should be called with range

For example

```vim
:call CountCEWords()
```

call `CountCEWords()` on current line.

```vim
:% call CountCEWords()
```

call `CountCEWords()` on the whole buffer.

```vim
:2,35 call CountTexCEWords()
```

call `CountTexCEWords()` on lines 2-35.

```vim
:'<,'> call CountTexCEWords()
```

call `CountTexCEWords()` on visual selected lines.

# Recommended mappings

At `~/.vimrc`,

```vim
nnoremap <leader>cc :% call CountCEWords()<CR>
```

At `~/.vim/ftplugin/tex.vim`,

```vim
nnoremap <buffer> <leader>cc :% call CountTexCEWords()<CR>
```

# Known bugs

When calling either function (see above) with `%` range, the cursor goes to the beginning of current buffer.

Workaround: use marks to remember cursor location.

```vim
nnoremap <leader>cc mq:% call CountCEWords()<CR>`q
```

etc.

# Dependency

- `python3` in PATH

In case on Windows it's called `python`, you may make a `python3.cmd` in PATH which call `python` in it.
