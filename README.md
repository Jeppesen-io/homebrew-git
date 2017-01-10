# homebrew-git
### Wraps `git` brew
Git, for me!

### bash/zsh completion support for core Git.

### Aliases
    st      status

    rb      rebase -i origin/master
    rbc     rebase --continue
    rba     rebase --abort

    ps      push
    psf     push --force-with-lease

    co      checkout
    ct      commit
    some    !git fetch -a && git pull

    dfm     diff origin/master
    l       log -p --color
    last    log -1 HEAD
