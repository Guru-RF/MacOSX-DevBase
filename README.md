git config --global user.name "First Last" (uw naam invulle)
git config --global user.email "ikke@mijndomain.com"
git config --global http.postBuffer 157286400

nieuwe git ... gebruik git fetch; git merge idpv git pull (of zet rebase merge)

install vcode
install platformio in vscode
install https://karabiner-elements.pqrs.org/ (map shift-ESC to tilde)
https://ke-complex-modifications.pqrs.org/?q=Remap%20R_Shift%2BESC%20to%20Tilde%20rules

install iterm2
make iterm default term
install iterm integrations

<https://www.python.org/downloads/>>

install python3.11.9 (not 12!!!! it brakes ansible)
install certs and shell check

install brew (https://brew.sh/)

install liquidprompt via git (powerline_full theme)

add to zshrc 
# Only load Liquidprompt in interactive shells, not from a script or from scp
[[ $- = *i* ]] && source ~/liquidprompt/liquidprompt
[[ $- = *i* ]] && source ~/liquidprompt/themes/powerline/powerline.theme
[[ $- = *i* ]] && lp_theme powerline

install powerline fonts in Git dir (mkdir ~Git/) git clone https://github.com/powerline/fonts.git --depth=1 && cd fonts && ./install.sh
in iterm2 change font to Roboto Mono for Powerline, Regular, 17px!
change colors to solarized dark in iterm2

check if vscode terminal also has the powerline fonts ...

brew update

brew upgrade

brew install fzf

$(brew --prefix)/opt/fzf/install

exec zsh

brew install rustup
rustup-init

cargo install exa

brew install cowsay-org/cowsay/cowsay-apj

brew install coreutils

brew install bat

brew install ripgrep

brew install zoxide

brew install entr

brew install wget

wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-462.0.1-darwin-arm.tar.gz
(in user root and install ./google-cloud-sdk/install.sh)
exec zsh
gcloud components update
gcloud auth login

brew install tmux
brew install tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm



# ansible stuff
pip3 install ansible-core==2.11.6
pip3 install apache_libcloud==3.3.1
pip3 install google-auth
pip3 install requests
pip3 install apache_libcloud==3.3.1

# ansible config file in user root directory
create file ~/.ansible.cfg
[galaxy]
server = https://old-galaxy.ansible.com/

#ansible galaxy collections install
ansible-galaxy collection install google.cloud:1.2.0
ansible-galaxy collection install community.google:1.0.0
ansible-galaxy collection install community.general:3.8.1

# tracerts
brew install mtr

install wireguard (use ip's from wp-voice-ansible)
login via glcoud ssh to one machine in each project

#diskutil
brew install ncdu
# downloader
brew install aria2
# calc
brew install insect
# mysql cli
brew install mycli
# postgresql
brew tap dbcli/tap
brew install pgcli
# cpuinfo
brew install neofetch
# mark down reader
brew install glow
# ftp/webdav etc
brew install duck
# top replacement
brew install bpytop
# find replacement
brew install fd
# tmate (remote terminal helper)
brew install tmate
# lazygit (tui)
brew install lazygit
# video downloader *youtube etc
brew install lux

# terminal notifier
brew install terminal-notifier
# neovim
brew install neovim
pip3 install pynvim
sh -c "$(wget -O- https://raw.githubusercontent.com/Shougo/dein-installer.vim/master/installer.sh)"
# redis (local redis for testing)
brew install redis
brew services start redis

# dust
brew install dust
# cheat (verkorte manual van commando's handig voor u jo)
brew install cheat
# terminal recorder
brew install asciinema
npm --global i -D git+https://github.com/miraclx/svgembed svg-term-cli
# zsh autocomplete
brew install zsh-autocomplete
# httpie
brew install httpie
# zsh completions
brew install zsh-completions
# kubectl tools goole
gcloud components install kubectl

# Perl
(install latest .zshrc)
rm -fr ~/perl5
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
brew install perl
curl -L https://cpanmin.us | perl - App::cpanminus
cpanm App::cpanoutdated
cpan-outdated | cpanm --notest
cpanm JSON::XS
cpanm Mojolicious
cpanm Mojo::Redis
cpanm Mojolicious::Plugin::Sentry
cpanm Config::YAML
cpanm Carton
cpanm -f Perl::PrereqScanner::Lite
cpanm App::scan_prereqs_cpanfile
cpanm File::JSON::Slurper
cpanm -f AnyEvent
cpanm  AnyEvent::AIO
cpanm Coro
cpanm Class::Refresh
cpanm Compiler::Lexer
cpanm Hash::SafeKeys
cpanm Perl::LanguageServer

echo ".DS_Store" > ~/.gitignore
echo ".vscode" > ~/.gitignore

git config --global core.excludesFile '~/.gitignore'

brew install --cask macfuse








