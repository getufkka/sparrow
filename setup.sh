#!/bin/bash

# === configuration ===
BASHPROFILE=$HOME/.bash_profile
BASHRC=$HOME/.bashrc
EMACS_VERSION="24.2"
EMACS_TARBALL=ftp://mirrors.kernel.org/gnu/emacs/emacs-$EMACS_VERSION.tar.gz
INSTALL="sudo apt-get install -y"
PACKAGES=(\
ant \
autoconf \
automake \
awesome \
beanstalkd \
bundler \
curl \
debhelper \
default-jdk \
g++ \
gitk \
irssi \
libcppunit-dev \
libreadline6 \
libreadline6-dev \
libtool \
python-setuptools \
python2.6-dev \
redis-server \
rubygems \
screen \
strace \
tcpdump \
unzip \
zip \
)
PREFIX=$HOME/prefix
PROJECTS=$HOME/projects
TMP=/tmp
ZOOKEEPER_VERSION="3.4.3"
export JAVA_HOME=/usr/lib/jvm/java-6-openjdk

# === setup ===
echo "Entering setup..."
pushd .
cd $HOME
BIN_DIR=$PREFIX/bin
LEIN_BIN=$BIN_DIR/lein
mkdir -p $BIN_DIR
mkdir -p $PROJECTS

# === packages ===
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

# === Leiningen ===
cd $HOME
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

# === prefix ===
cd $HOME
echo "Setting up $PREFIX"
git clone git@github.com:gsilk/prefix.git
cd $PREFIX
make
cd $HOME
ln -sf $PREFIX/.bash_aliases .bash_aliases
ln -sf $PREFIX/.emacs.d .emacs.d
ln -sf $PREFIX/.gdbinit .gdbinit
ln -sf $PREFIX/.gemrc .gemrc
ln -sf $PREFIX/.gitconfig .gitconfig
ln -sf $PREFIX/.screenrc .screenrc
ln -sf $PREFIX/.profile .profile
ln -sf $PREFIX/.zshrc .zshrc


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
popd
