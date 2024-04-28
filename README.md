git config --global user.name "First Last" (uw naam invulle)
git config --global user.email "ikke@mijndomain.com"

nieuwe git ... gebruik git fetch; git merge idpv git pull (of zet rebase merge)

install vcode
install platformio in vscode
install https://karabiner-elements.pqrs.org/ (map shift-ESC to tilde)

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

brew install rust

cargo install exa

brew install cpanm

pip3 install ansible-core==2.11.6

brew install cowsay

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

brew install tmux


