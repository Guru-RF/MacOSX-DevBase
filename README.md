# Mac Dev Environment Setup

## Git Configuration

```bash
git config --global user.name "First Last"       # fill in your name
git config --global user.email "ikke@mijndomain.com"
git config --global http.postBuffer 157286400
```

> **Tip:** Use `git fetch` + `git merge` instead of `git pull` (or set rebase merge).

---

## Editors & Tools

- Install **VS Code**
- Install **PlatformIO** in VS Code
- Install [Karabiner-Elements](https://karabiner-elements.pqrs.org/) (map Shift-ESC to tilde)

---

## Terminal

- Install **iTerm2** and make it the default terminal
- Install iTerm2 shell integrations

---

## Python (on 26.4 Tahoe this is the default, so new install is not nesc)

- Install latest Python 3 from <https://www.python.org/downloads/>
- Install certs and run shell check

---

## Homebrew

Install [Homebrew](https://brew.sh/):

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

---

## Liquidprompt

Install Liquidprompt via git (powerline_full theme):

```bash
git clone https://github.com/liquidprompt/liquidprompt.git ~/liquidprompt
```

Add to `~/.zshrc`:

```bash
# Only load Liquidprompt in interactive shells, not from a script or from scp
[[ $- = *i* ]] && source ~/liquidprompt/liquidprompt
[[ $- = *i* ]] && source ~/liquidprompt/themes/powerline/powerline.theme
[[ $- = *i* ]] && lp_theme powerline
```

### Powerline Fonts

```bash
mkdir -p ~/Git/generic
cd ~/Git/generic
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts && ./install.sh
```

- In iTerm2: change font to **Roboto Mono for Powerline**, Regular, 17px
- Change colors to **Solarized Dark** in iTerm2
- Check if VS Code terminal also has the Powerline fonts

---

## Brew Packages

```bash
brew update
brew upgrade
```

### Core CLI Tools

```bash
brew install fzf
$(brew --prefix)/opt/fzf/install
exec zsh

brew install rustup
rustup-init
cargo install exa

brew install cowsay
brew install coreutils
brew install bat
brew install ripgrep
brew install zoxide
brew install entr
brew install wget
```

---

## Google Cloud SDK

```bash
wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-darwin-arm.tar.gz
# Extract in user home directory, then:
./google-cloud-sdk/install.sh
exec zsh
gcloud components update
gcloud auth login
```

---

## tmux

```bash
brew install tmux
brew install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

---

## Ansible

```bash
brew install python@3.11
python3.11 -m venv ansible-env
source ansible-env/bin/activate

pip3 install ansible-core==2.11.6
pip3 install apache_libcloud==3.3.1
pip3 install google-auth
pip3 install requests
```

### Ansible Config

Create `~/.ansible.cfg`:

```ini
[galaxy]
server = https://old-galaxy.ansible.com/
```

### Ansible Galaxy Collections & Roles

```bash
ansible-galaxy collection install google.cloud:1.2.0
ansible-galaxy collection install community.google:1.0.0
ansible-galaxy collection install community.general:3.8.1
ansible-galaxy collection install ansible.windows
ansible-galaxy role install googlecloudplatform.google_cloud_ops_agents
```

---

## Networking

```bash
# Traceroute
brew install mtr
```

- Install **WireGuard** (use IPs from wp-voice-ansible)
- Login via `gcloud ssh` to one machine in each project

---

## More Brew Packages

```bash
# Disk usage
brew install ncdu

# Downloader
brew install aria2

# Calculator
brew install insect

# MySQL CLI
brew install mycli

# PostgreSQL CLI
brew tap dbcli/tap
brew install pgcli

# System info
brew install neofetch

# Markdown reader
brew install glow

# FTP/WebDAV etc.
brew install duck

# Top replacement
brew install bpytop

# Find replacement
brew install fd

# Remote terminal helper
brew install tmate

# Lazygit (TUI)
brew install lazygit

# Video downloader (YouTube etc.)
brew install lux

# Terminal notifier
brew install terminal-notifier
```

---

## Neovim

```bash
brew install neovim
pip3 install pynvim
sh -c "$(wget -O- https://raw.githubusercontent.com/Shougo/dein-installer.vim/master/installer.sh)"
nvim +"call dein#update()" +qall
```

---

## Redis (Local for Testing)

```bash
brew install redis
brew services start redis
```

---

## Even More Brew Packages

```bash
# Disk usage (alternative)
brew install dust

# Cheat sheets (handy shortened manuals)
brew install cheat

# Terminal recorder
brew install asciinema
npm --global i -D git+https://github.com/miraclx/svgembed svg-term-cli

# Zsh autocomplete
brew install zsh-autocomplete

# HTTP client
brew install httpie

# Zsh completions
brew install zsh-completions
```

---

## kubectl

```bash
gcloud components install kubectl
```

---

## OpenSSL

```bash
brew install openssl
```

---

## Perl

Install latest `.zshrc`, then:

```bash
rm -fr ~/perl5
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
brew install perl
curl -L https://cpanmin.us | perl - App::cpanminus
cpanm App::cpanoutdated
cpan-outdated | cpanm --notest
```

### Perl Modules

```bash
cpanm JSON::XS
cpanm Mojolicious
cpanm Mojo::Redis
cpanm LWP::Protocol::https
cpanm Mojolicious::Plugin::Sentry
cpanm Config::YAML
cpanm Carton
cpanm -f Perl::PrereqScanner::Lite
cpanm App::scan_prereqs_cpanfile
cpanm File::JSON::Slurper
cpanm -f AnyEvent
cpanm AnyEvent::AIO
cpanm Coro
cpanm Class::Refresh
cpanm Compiler::Lexer
cpanm Hash::SafeKeys
cpanm Perl::LanguageServer
```

### Redis::Fast (requires OpenSSL)

```bash
export LIBRARY_PATH=$LIBRARY_PATH:/opt/homebrew/opt/openssl/lib/
cpanm -n Redis::Fast
```

### Imager::File::PNG (requires libpng)

```bash
export LIBRARY_PATH=$LIBRARY_PATH:/opt/homebrew/Cellar/libpng/1.6.44/lib/
export C_INCLUDE_PATH=$C_INCLUDE_PATH:/opt/homebrew/Cellar/libpng/1.6.44/include/
cpanm Imager::File::PNG
```

---

## Global Gitignore

```bash
echo ".DS_Store" > ~/.gitignore
echo ".vscode" >> ~/.gitignore
git config --global core.excludesFile '~/.gitignore'
```

---

## MacFUSE

```bash
brew install --cask macfuse
```

---

## SSL Certificates

Export system root certificates:

```bash
security find-certificate -a -p \
  /System/Library/Keychains/SystemRootCertificates.keychain \
  /Library/Keychains/System.keychain > ~/.mac-ca.pem
```

Add to `~/.zshrc`:

```bash
export SSL_CERT_FILE="$HOME/.mac-ca.pem"
export MOJO_CA_FILE="$HOME/.mac-ca.pem"           # optional, nice for Mojolicious
export PERL_LWP_SSL_CA_FILE="$HOME/.mac-ca.pem"   # optional, helps LWP too
```
