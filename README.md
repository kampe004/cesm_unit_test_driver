The files in here can be copied (or linked) to the directory containing the
top-level CMakeLists.txt file for unit tests (e.g., components/clm/src for CLM
unit tests). Then unit tests can be run on my local machine (roo2) using:

```
make -j 4 -f Makefile.utest config
make -j 4 -f Makefile.utest test
```

For a different machine, configure CESM_Macros.cmake for your machine (setting
paths, etc.). The Makefile shouldn't need to be modified, in theory.

The Makefile assumes a path to CESM root that works for recent versions of
CLM. For unit tests not run out of CLM, or for an incompatible version of CLM
(with different directory structure), you also need to specify
CESM\_ROOT\_RELPATH, as in:

```
make -j 4 -f Makefile.utest CESM_ROOT_RELPATH=../.. config
make -j 4 -f Makefile.utest CESM_ROOT_RELPATH=../.. test
```
