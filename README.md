# Zlang stdlib

Repo for zlang standart library. Currently WIP.

Library can be written with zlang or any language binary compatible with zlang (or c). In case if the implementation is not written with zlang, you should put it in the same place where `.use.zl` header is located and name an implementation the same way it's header called.

## Endpoint
In zlang, header file can have implementations in it, (but you should not! see note later). It can include external implementations of some functions by using `wrap` keyword. In this case, file should be compiled into a shared object (.so) and be located in the same place where it's `.use.zl` file (header) is located. Example:

```
use/math
├── math.c # External implementation of some functions
└── math.use.zl
```

After compilation:

```
use/math
├── math.c
├── math.so
└── math.use.zl
```

Note that any library function implemented in the .use.zl file will not have any benefits of the compiled .so library. So alternatively, you should write it in separate .zl file and then compile it into .so (will be done by a script later)

If some library has custom, non usual programming language or a way it should be compiled to `.so`, create custom `build.sh` in the library directory

## TODO
- [x] Tests
- [ ] Tests script
- [x] Build script
- [ ] Instalation (into ~/.local/lib or /usr/local/lib)
