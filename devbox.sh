apt update
curl -sL https://raw.githubusercontent.com/IBM-Cloud/ibm-cloud-developer-tools/master/linux-installer/idt-installer | bash
apt install -y golang curl dirmngr apt-transport-https lsb-release ca-certificates gcc g++ make tmux python3-pip mosh bat
ln -s /usr/bin/batcat /usr/local/bin/bat
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
apt update && apt install yarn
apt install -y nodejs
npm install -g ungit
npm install -g typescript-language-server
npm i @ibmgaragecloud/cloud-native-toolkit-cli
git credential-cache start
pip install black python-lsp-server

add-apt-repository ppa:ultradvorka/ppa && apt-get update &&  apt-get install hstr && hstr --show-configuration >> ~/.bashrc && . ~/.bashrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ~/projects

curl -vvv https://gist.githubusercontent.com/jpapejr/4c437d71511ec7c44e00302b33d8575f/raw/cbee88686dc25cf92bd26e148afcfbeb7156714c/.tmux.conf -o ~/.tmux.conf
curl -vvv https://gist.githubusercontent.com/jpapejr/7ad2aba0ea3e270dc99129bd7ca764f0/raw/7ef3ae8b9dc60a78da792048c577b39b25a69a78/.vimrc -o ~/.vimrc


git config credential.helper cache