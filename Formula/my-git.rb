class MyGit < Formula
  desc 'Install Git how I like it'
  url 'https://github.com/Jeppesen-io/homebrew-git/archive/master.zip'
  homepage 'https://github.com/Jeppesen-io/homebrew-git'
  version '1.1.0'

  depends_on 'git'
  depends_on 'curl'

  bottle :unneeded

  def install

    # Get home dir (stripped by homebrew)
    home_dir = `sudo -Hu $USER bash -c 'echo -n $HOME'`

    # Create xdg dirs for git
    system 'mkdir', '-vp', "#{home_dir}/.config/git/"
    system 'mkdir', '-vp', "#{home_dir}/.config/bash/"

    # Prevent "empty install"
    system 'touch'    , "#{prefix}/config"

    # Use xdg config location
    system 'touch'    , "#{home_dir}/.config/git/config"

    # Implicitly push for the current branch regardless of if that branch exists on origin
    # http://stackoverflow.com/questions/17096311/why-do-i-need-to-explicitly-push-a-new-branch
    system 'git', 'config', '--global', '--replace-all', 'push.default',  'current'

    # Create global git alias
    def git_alias(name,action)
      system 'git', 'config', '--global', '--replace-all', "alias.#{name}", action,
    end

    git_alias 'lol',     'log --graph --decorate --oneline'
    git_alias 'lola',    'log --graph --decorate --oneline --all'
    git_alias 'co',      'checkout'
    git_alias 'ct',      'commit'
    git_alias 'ps',      'push'
    git_alias 'pl',      'pull'
    git_alias 'dfm',     'diff origin/master'
    git_alias 'st',      'status'
    git_alias 'last',    'log -1 HEAD'
    git_alias 'some',    '!git fetch -a && git pull'
    git_alias 'rb',      'rebase -i origin/master'

    # Bash completion
    system 'curl', '-fLo', "#{home_dir}/.config/bash/git-completion.bash",
      'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash'

  end

end
