#!/bin/sh

PYENV_VER_PREFIX=2.7
PYENV_VER_SUFFIX=-dev
PYENV_VER_FULL=${PYENV_VER_PREFIX}${PYENV_VER_SUFFIX}
CMD=$1
shift 1

prepare() {
  PYTHON_CONFIGURE_OPTS="--enable-shared" CFLAGS="-m32" LDFLAGS="-m32" pyenv install ${PYENV_VER_FULL}
  pyenv local ${PYENV_VER_FULL}
  pip install nose
}

unprepare() {
  pyenv local --unset
  pyenv uninstall $PYENV_VER_FULL
}

configure() {
  cmake \
    -DPYTHON_LIBRARY=$(pyenv prefix)/lib/libpython${PYENV_VER_PREFIX}.so \
    -DPYTHON_INCLUDE_DIR=$(pyenv prefix)/include/python${PYENV_VER_PREFIX} \
    -DCMAKE_C_FLAGS="-m32 -DASMJIT_X86" \
    -DCMAKE_CXX_FLAGS="-m32 -DASMJIT_X86" \
    $@
}

build() {
  shift 1
  make $@
}

clean() {
  make clean
}

test() {
  nosetests $@
}

help() {
  echo "Usage: $0 <command> [ARGS]"
  echo "Commands:"
  echo "  prepare   - uses pyenv to build a 32-bit environment, makes it local and installs nose"
  echo "  unprepare - uses pyenv to remove the created environment"
  echo "  configure - executes cmake passing the proper pyenv prefix and 32-bit flags"
  echo "  build     - executes make"
  echo "  clean     - executes make clean"
  echo "  test      - executes nosetests"
  echo "  help      - show this help"
}

if [ -z $CMD ]; then
  help
else
  eval $CMD $@ || help
fi
