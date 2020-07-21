# Minimalistic CMake C99 Project

Example C99 CMake project that assumes CMake 3.10 or later, and pre­fers the
[**Ninja**][wp-ninja] build tool with CMake's `"Ninja Multi-Config"` op­tion.
Re­cent ver­sions of both CMake and Ninja exe­cu­ta­bles, are easy to ob­tain for
Linux, macOS, FreeBSD & Windows, keep­ing ex­amp­les and in­struct­ions simp­ler.

NOTE: The `"Ninja Multi-Config"` generator, is only available from CMake 3.15.

The `CMakeLists.txt` file is generator-agnostic, and the C code is por­ta­ble
C99 code. Use any pre­fer­red ge­ne­ra­tor if Ninja is not avail­able, but the
sup­plied `CMakeLists.txt` file re­quires CMake 3.10 or higher (prefer 3.17).

## Best Practices

This example does not necessarily represent ‘best prac­tic­es’, yet is still
not *truly* mi­ni­mal; for ex­amp­le, con­sid­er these op­tion­al feat­ures used:

 * `DESCRIPTION`, `VERSION` and `LANGUAGES` are optional.
 * A more compliant preprocessor choice for MSVC is good, but not re­quired.
 * Setting strict C99 standard compliance is opinionated.
 * Increased compiler warning level is opinionated.
 * Setting project and executable names to project directory name!
 * Using `GLOB` to ‘collect’ source and header files.
 * Executable in `‹project›/bin/Debug‖Release` (default is `build` di­rec­to­ry).

The last two points make it easy to re-use this `CMakeLists.txt` file al­most
ver­ba­tim in other simple C pro­jects. Change a new pro­ject's `DESCRIPTION` and
`VERSION`. Keep the ‹*pro­ject*› di­rec­to­ry name simple.

## Generate Build Files

When cal­ling `cmake` with­out ar­gu­ments, it looks in the *cur­rent* di­rec­to­ry
for a `CMakeLists.txt` file. Re­com­mend­ed steps will keep the ‹*pro­ject*›
di­rec­to­ry as the cur­rent di­rec­to­ry. CMake 3.17 example that uses `"Ninja Multi-Config"`:

```sh
cd ‹project›                                 #←make project dir current.
cmake -S . -B build -G "Ninja Multi-Config"  #←create build files.
cmake --build build --config Release‖Debug   #←build the project.
bin/Release‖Debug/‹project›                  #←run the executable.
```

An example that uses the *default* generator for your platform, and CMake 3.10:

```sh
cd ‹project›                                 #←make project dir current.
mkdir build; cd build                        #←create &cd to build directory.
cmake .. -DCMAKE_BUILD_TYPE=Release‖Debug    #←create build files.
cmake --build .                              #←build the project.
../bin/Release‖Debug/‹project›               #←run the executable.
```

Optionally, one can install the executable (copy to some `bin` di­rec­to­ry). It
may be a good idea to first do a ‘clean re­build’. The `--prefix` ar­gu­ment,
must be some­thing like `$HOME`, or `/usr/local` (omit the `bin` part).

```sh
cmake --build build --config Release --clean-first
cmake --install --prefix $HOME --strip
```

The `--strip` reduces the size of the executable some­what. This is op­tion­al.

NOTE: On many systems, `$HOME/bin` is always present, and first in `PATH`. Also
po­pu­lar, is `$HOME/.local/bin`, in which case, use: `--prefix $HOME/.local`.

## Clean Project

Clean the ‹*project*› before copying or ar­chiv­ing, by re­curs­ive­ly de­let­ing any
`bin` and `build` di­rec­to­ries in­side. For example:

```sh
cd ‹project›
rm -rf bin build
cd ..
cp -r ‹project› ‹new-project›
```

## repl.it

The included `.replit` file is for use with the **Run** button on [repl.it][repls]
(See their [do­cu­men­ta­tion][repl-doc]). If [repl.it][repls] is not used, the `.replit`,
and `replenv` files can be de­let­ed, and this whole sec­tion ig­nor­ed.

In case this project is placed in a sub-di­rec­to­ry of a ‘repl’ , e.g.: in
`cmkcmin`, you can use this in the `.replit` file:

```
run = "clear; cd cmkcmin; sh ./build.sh
```

Since repl.it provides only CMake 3.10, a later CMake (3.17.3) Linux binary can
be [down­loaded][cmake-dl], and ex­tract­ed to a di­rec­to­ry in your ‘repl’. Amend
the `PATH` in `build.sh`. Some­thing like this in the first command:

```sh
export PATH=$HOME/‹repl›/.local/bin:$PATH
```

Where `‹repl›` must be the name of the ‘repl’; and as­sum­ing that `cmake` and
re­lat­ed pro­grams can be found in `./.local/bin`. 

The following commands assume that your ‘repl’ directory (`‹repl›`) is the cur­rent
work­ing di­rec­to­ry. Re­place `‹repl›` with your ‘repl’ name.

```sh
cd $HOME/‹repl›
mkdir .local; cd .local
export TD=cmake-3.17.3-Linux-x86_64
export TF=$TD.tar.gz
curl -LO https://github.com/Kitware/CMake/releases/download/v3.17.3/$TF
tar xvzf $TF && rm $TF
mv $TD/* . && rmdir $TD
rmdir -rf doc
> replenv cat <<EOT
export PATH=$PWD/.local/bin:$PATH
export MANPATH=$PWD/.local/man:$MANPATH
alias l='ls --color=auto -F'
alias ll='ls --color=auto --group-directories-first -AogF'
EOT
```

Every time the ‘repl’ environment is (re)loaded, source (`.`) the `replenv` to
set `PATH` and alias­es in the ter­mi­nal.

```sh
. ./replenv
```

You ‘repl’ *directory* will persist, but not the vir­tual machine. It can re­load
at any time due to bad con­nect­ions, or other reas­ons. Thus the need for some­thing
like the ex­amp­le `replenv` created.

### Clone from GitHub

Create a new C repl on repl.it. In the terminal, run:

```sh
rm -rf * .*
git clone https://github.com/funvake/cmkc99min.git .
```

Notice the trailing period!

The editor component may crash. Reload the repl if ne­ces­sa­ry. Click the **Run**
but­ton to run the pro­ject. The di­rec­to­ry must be com­plete­ly empty for **`git`**
to per­form the clone.

This can all be avoided, if the option to clone from GitHub is used, when a
new repl is crea­ted. It will also au­to­ma­ti­cal­ly dis­play the `README.md` file.

[cmake-dl]:
   https://cmake.org/download/
   "CMake — Downloads page"
[wp-ninja]:
   https://en.wikipedia.org/wiki/Ninja\_(build\_system)
   "Wikipedia — Ninja (build system)"
[repls]:
   https://repl.it/site/ide
   "repl.it — Features"
[repl-doc]:
   https://docs.repl.it/
   "repl.it — Documentation"

