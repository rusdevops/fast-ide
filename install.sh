set -e

sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test" && sudo apt update
sudo apt install -y wget
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
sudo apt-add-repository "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-7 main"
sudo apt install -y libcurl4-gnutls-dev curl \ # nodejs npm
     g++-7 lcov gcovr cmake cmake-data clang-7 # python3-pip 

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | zsh
nvm install v8.12.0
nvm use v8.12.0
nvm install-latest-npm

curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | zsh
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
PYTHON_CONFIGURE_OPTS='--enable-shared' pyenv install 3.5.3
pyenv shell 3.5.3

pip3 install cpplint && npm install -g jscpd

sudo add-apt-repository -y ppa:neovim-ppa/stable && apt update
sudo apt -y install curl git git-extras zsh astyle python3-dev \
     neovim silversearcher-ag python3-pip python-pip \
     tmux exuberant-ctags valgrind gdb

git clone git://github.com/rkitover/vimpager 
cd vimpager && make install && cd .. && rm -rf vimpager

pip3 install komodo-python3-dbgp pynvim
pip2 install pynvim

curl -L http://install.ohmyz.sh | sh || true

git clone https://github.com/facebook/PathPicker.git /usr/local/PathPicker
ln -s /usr/local/PathPicker/fpp /usr/local/bin/fpp

mkdir $HOME/.zsh
curl -L git.io/antigen > $HOME/.zsh/antigen.zsh
curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.nvim/backup
mkdir -p $HOME/.nvim/swap
cp .zshrc $HOME/
cp init.vim $HOME/.config/nvim/
cp .tmux.conf $HOME/

nvim +PlugInstall +qall

git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
git clone https://github.com/yonchu/vimman.git $HOME/.zsh/vimman
zsh --rcs $HOME/.zshrc || true