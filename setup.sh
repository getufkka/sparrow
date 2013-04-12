#!/bin/bash

# === configuration ===
BASHPROFILE=$HOME/.bash_profile
BASHRC=$HOME/.bashrc
EMACS_VERSION="24.2"
EMACS_TARBALL=ftp://mirrors.kernel.org/gnu/emacs/emacs-$EMACS_VERSION.tar.gz
INSTALL="sudo apt-get install -y"
OH_MY_ZSH=$HOME/.oh-my-zsh
PACKAGES="ant autoconf automake avahi-daemon awesome curl debhelper default-jdk g++ gitk gnome irssi libcppunit-dev libncurses5 libncurses5-dev libreadline6 libreadline6-dev libtool python-setuptools redis-server rubygems screen strace tcpdump unzip zip zsh"
PREFIX=$HOME/sparrow
PROJECTS=$HOME/projects
TMP=/tmp
ZOOKEEPER_VERSION="3.4.3"
export JAVA_HOME=/usr/lib/jvm/java-6-openjdk

# === setup ===
echo "Entering setup..."
pushd .
cd $HOME
mkdir -p $PROJECTS

# === packages ===
sudo apt-get update
$INSTALL $PACKAGES

# === emacs ===
echo "Looking for emacs 24..."
emacs --version | grep "GNU Emacs 24"
if [ $? -ne 0 ] ; then
    cd $TMP
    wget $EMACS_TARBALL
    tar xzvf emacs-$EMACS_VERSION.tar.gz
    cd emacs-$EMACS_VERSION
    ./configure --with-x-toolkit=no --with-xpm=no --with-jpeg=no --with-png=no --with-gif=no --with-tiff=no
    make
    sudo make install
fi

# === oh-my-zsh ===
if [ -e $OH_MY_ZSH ] ; then
    echo "Oh-My-Zshell is already installed"
else
    cd $HOME
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

# === prefix ===
cd $HOME
echo "Setting up $PREFIX"
ln -sf $PREFIX/.bash_aliases .bash_aliases
ln -sf $PREFIX/.bash_profile .bash_profile
ln -sf $PREFIX/.emacs.d .emacs.d
ln -sf $PREFIX/.gdbinit .gdbinit
ln -sf $PREFIX/.gemrc .gemrc
ln -sf $PREFIX/.gitconfig .gitconfig

# === Leiningen ===
cd $HOME
BIN_DIR=$PREFIX/bin
LEIN_BIN=$BIN_DIR/lein
mkdir -p $BIN_DIR
if [ -e $LEIN_BIN ] ; then
    echo "Leiningen is already installed to $LEIN_BIN"
else
    echo "Downloading and installing leiningen to $BIN_DIR"
    cd $BIN_DIR
    wget -N -nd http://raw.github.com/technomancy/leiningen/preview/bin/lein
    chmod 755 lein
    # run lein once so it can bootstrap itself
    $LEIN_BIN
fi

# === extensions ===
if [ $EXTENDED ] ; then
    # === zeromq 2.1.7 ===
    cd $PREFIX
    sudo apt-get install uuid-dev
    tar xzvf zeromq-2.1.7.tar.gz
    cd zeromq-2.1.7
    ./configure && make && make check && sudo make install

    # === libzmq ===
    cd $PROJECTS
    if [ ! -e libzmq ] ; then
        git clone git://github.com/zeromq/libzmq.git
    fi

    # === JZMQ ===
    cd $PROJECTS
    if [ ! -e jzmq ] ; then
        git clone git://github.com/nathanmarz/jzmq.git
    fi
    cd jzmq
    ./autogen.sh && ./configure --with-zeromq=/usr/local/lib && make && sudo make install

    # === Zookeeper ===
    cd $BIN_DIR
    wget http://mirror.symnds.com/software/Apache/zookeeper/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION.tar.gz
    tar xzvf zookeeper-$ZOOKEEPER_VERSION.tar.gz
    cd zookeeper-$ZOOKEEPER_VERSION
    ant deb
fi

# === teardown ===

echo "=========================================================="
echo "Hey there, you might want to now edit your ~/.zshrc and"
echo "choose a theme you like. Enjoy!"
echo "=========================================================="

popd
