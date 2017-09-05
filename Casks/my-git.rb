cask 'my-git' do

  version '1.1'
  url 'https://github.com/Jeppesen-io/homebrew-git/archive/master.zip'
  homepage 'https://github.com/Jeppesen-io/homebrew-git'
  sha256 :no_check

  depends_on formula: 'git'
  depends_on formula: 'curl'

  preflight do
    # Create xdg dirs for git
    `mkdir -vp #{ENV['HOME']}/.config/git`
    `mkdir -vp #{ENV['HOME']}/.cache/git`
    `mkdir -vp #{ENV['HOME']}/.local/git`

    `rm -v #{ENV['HOME']}/.config/git/config 2> /dev/null`
    `touch #{ENV['HOME']}/.config/git/config`

  end

  postflight do

    # Implicitly push for the current branch regardless of if that branch exists on origin
    # http://stackoverflow.com/questions/17096311/why-do-i-need-to-explicitly-push-a-new-branch
    system 'git', 'config', '--global', '--replace-all', 'push.default',  'current'

    # Create global git alias
    def git_alias(name,action)
      system 'git', 'config', '--global', '--replace-all', "alias.#{name}", action
    end

    git_alias 'a',        'add'
    git_alias 'co',       'checkout'
    git_alias 'ct',       'commit'
    git_alias 'some',     '!git fetch -a && git pull'

    git_alias 'ps',       'push'
    git_alias 'psf',      'push --force-with-lease'

    git_alias 's',        'status'

    git_alias 'st',       'stash'
    git_alias 'stp',      'stash pop'
    git_alias 'stc',      'stash clear'

    git_alias 'dfm',      'diff origin/master'
    git_alias 'l',        'log -p --color'
    git_alias 'l1',       'log -1 HEAD'

    git_alias 'rb',       'rebase -i origin/master'
    git_alias 'rba',      'rebase --abort'
    git_alias 'rbc',      'rebase --continue'

    git_alias 'ignore',   'update-index --assume-unchanged'
    git_alias 'unignore', 'update-index --no-assume-unchanged'

  end

end
