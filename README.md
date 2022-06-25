# Description

This plugin counts the number of wide characters and the number of ASCII words.

# Installation

Via your favorite plugin manager.

# Commands

- `Wc`: (range command) count words in current buffer

For example

```vim
:Wc
```

count words in current line.

```vim
:%Wc
```

count words in the whole buffer.

```vim
:2,35Wc
```

count words in lines 2-35.

```vim
:'<,'>Wc
```

count words in visual selected lines.

# Recommended mappings

At `~/.vimrc`,

```vim
nnoremap <leader>cc :%Wc<CR>
```

# Known bugs

When invoking `:Wc` command with `%` range, the cursor goes to the beginning of current buffer.

Workaround: use marks to remember cursor location.

```vim
nnoremap <leader>cc mq:%Wc<CR>`q
```

etc.

# Dependencies

- `python3` in PATH

In case on Windows it's called `python`, you may make a `python3.cmd` in PATH which call `python` in it.

- `detex` in PATH when counting words in `.tex` files

This should already be included in a LaTeX distribution.
