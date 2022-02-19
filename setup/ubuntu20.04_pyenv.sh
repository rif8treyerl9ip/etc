
# ubuntu20.04
# pyenv
# virtualenv

# ubuntu20.04 pyenvセットアップ
# 以下のコマンドを全部実行
# 参考：パッケージ類はhttps://zenn.dev/neruo/articles/install-pyenv-on-ubuntu
# 参考：deb-srcの追記はhttps://qiita.com/MusicScience37/items/4537233b840e2133cd32#

# https://zenn.dev/neruo/articles/install-pyenv-on-ubuntu
sudo apt-get update
sudo apt-get upgrade

sudo apt-get install -y libffi
sudo apt-get install -y libssl
sudo apt-get install -y zlib1g
sudo apt-get install -y liblzma
sudo apt-get install -y tk-dev
sudo apt-get install -y libbz2
sudo apt-get install -y libreadline
sudo apt-get install -y libsqlite3
sudo apt-get install -y libopencv
sudo apt-get install -y build
sudo apt-get install -y git
sudo apt-get install -y tree
sudo apt-get install -y tmux

# アンインストールする場合
# sudo apt remove tree

# libffi-dev: Foreign function interface library (FFI)
# libssl-dev: Secure Sockets Layer library (SSL)
# zlib1g-dev: Compression library (zip)
# liblzma-dev: XZ-format compression library (pandas)
# tk-dev: Toolkit for Tcl and X11 (tkinter)
# libbz2-dev: high-quality block-sorting file compressor (bz2)
# libreadline-dev: GNU readline and history (readline)
# libsqlite3-dev: SQLite 3 development files (sqlite3)
# libopencv-dev: development files for opencv (OpenCV)
# build-essential: Informational list of build-essential packages (C/C++ compiler)
# git: fast, scalable, distributed revision control system


##################################### deb-src
# ・debパッケージの構築に必要なソースコードなどのリストの取得に利用
# ・オリジナルのプログラムソースとDebianのコントロールファイル(.dsc)，およびプログラムを'Debian化'するのに必要な変更点を含んだdiff.gz からなるソースパッケージ（www.debian.org/参照）
sudo vim /etc/apt/sources.list
sudo cat << 'EOF' >> /etc/apt/sources.list
deb-src http://archive.ubuntu.com/ubuntu/ focal-updates main # /etc/apt/sources.list の末尾に追記
EOF
sudo apt update
sudo apt build-dep python3.8
# > apt build-dep はソースコードからビルドするのに必要なパッケージをまとめてインストールしてくれるコマンドです。ここでは、CPython 3.8 のビルドに必要なパッケージをインストールしています。
##################################### deb-src

# pyenvセットアップ
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

cat << 'EOF' >> ~/.bashrc
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
EOF

source ~/.bashrc
# python3.8.0インストールしてをグローバルに設定
pyenv install 3.8.0
pyenv global 3.8.0
pyenv versions # バージョン確認

# 実行の様子
# $ pythonだとcommand not foundだが3.8,3とつけると起動する。こんな仕様だっけ？
# $ python3.8
# $ python3
# Python 3.8.10 (default, Nov 26 2021, 20:14:08)
# [GCC 9.3.0] on linux
# Type "help", "copyright", "credits" or "license" for more information.
# >>>

# pipのセットアップ
sudo apt-get -y install python3-pip
pip list

# virtualenvのセットアップ
sudo pip install virtualenv


###### 仮想環境のセットアップ 1
# mkdir /var/tmp/venv
# ## 仮想環境の初期化
# virtualenv /var/tmp/venv/
# ls /var/tmp/venv/
# ## 仮想環境の有効化
# source /var/tmp/venv/bin/activate 

# ## 仮想環境の無効化
# deactivate
# ## 仮想環境の削除
# rm -rf /var/tmp/venv
###### 仮想環境のセットアップ 1



###### 仮想環境のセットアップ 2
# 使用するPythonインタプリタを指定して仮想環境を作成
mkdir -p /var/tmp/test
virtualenv /var/tmp/test -p $(which python3.8)
source /var/tmp/test/bin/activate

pip install autopep8
pip install flake8
pip install ipython
pip install pudb
pip install pycodestyle
pip install pydocstyle
pip install pylint
pip install radon
pip install click
poetry add click
# pip list | grep click

# ここまでで作成した仮想環境にのみ上記のツールが入っていることを確認できれば環境構築終了


radon cc a.py