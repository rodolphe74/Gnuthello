# Gnuthello
Othello Minimax tree visualization in GNUStep Objective C (from a black point of view).

# Prepare Linux environnement

```shell
# install gnustep develop librairies and pdf tools
sudo apt install gnustep-devel
sudo apt install pdf2svg

# install clang compiler
sudo apt install clang

# some variables need maybe to be set (at least on my mint linux for clang to compile)
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export CPLUS_INCLUDE_PATH=/usr/include/c++/11:/usr/include/x86_64-linux-gnu/c++/11
export LIBRARY_PATH=$LIBRARY_PATH:/usr/lib/gcc/x86_64-linux-gnu/11
``

```shell
# clone libobjc2
git clone --branch v2.1  https://github.com/gnustep/libobjc2.git
cd libobjc2
git submodule update --init
```

edit CMakeLists.txt and comment line 189:
```shell
# set(INSTALL_TARGET objc)
```

```shell
# and finish compilation of libobjc2
mkdir Build
cd Build
cmake ..
make
sudo make install
```

# Run a minimax sample
```shell
make run
```

![Minimax tree](./minimax.svg)
