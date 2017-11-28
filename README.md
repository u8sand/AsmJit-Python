Simple Python wrapper for AsmJit using SWIG.

Thanks to Petr Kobalicek and the AsmJit developers for this wonderful library!

asmjit homepage: http://code.google.com/p/asmjit/

## Helper Script

Added a helper script to get this running on my own system. A working [pyenv](https://github.com/pyenv/pyenv/) installation is required for this to work.

Setup steps:
```
./helper.sh prepare
./helper.sh configure .
./helper.sh build -j2
./helper.sh test
```
