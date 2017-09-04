class MyGit < Formula
  desc 'Install Git how I like it'
  url 'https://github.com/Jeppesen-io/homebrew-git/archive/master.zip'
  homepage 'https://github.com/Jeppesen-io/homebrew-git'
  version '1.2.2'

  depends_on 'git'
  depends_on 'curl'

  bottle :unneeded

  def install

    # Create xdg dirs for git
    system 'mkdir', '-vp', "#{HOME}/.config/git/"
    system 'mkdir', '-vp', "#{HOME}/.config/bash/"

    # Prevent "empty install"
    system 'touch'    , "#{prefix}/config"

    # Use xdg config location
    system 'touch'    , "#{home_dir}/.config/git/config"

    # Implicitly push for the current branch regardless of if that branch exists on origin
    # http://stackoverflow.com/questions/17096311/why-do-i-need-to-explicitly-push-a-new-branch
    system 'git', 'config', '--global', '--replace-all', 'push.default',  'current'

    # Create global git alias
    def git_alias(name,action)
      system 'git', 'config', '--global', '--replace-all', "alias.#{name}", action
    end

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

    # Bash completion
    system 'curl', '-fLo', "#{home_dir}/.config/bash/git-completion.bash",
      'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash'

  end

end
