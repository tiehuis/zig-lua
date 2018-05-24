Example of embedding the lua interpreter in a zig program.

Some things that would be cool to do:
 - get translate-c parsing all the macros in the header files correctly
 - longjmp error handling example case
 - get [zligc](https://github.com/tiehuis/zligc) far enough along to avoid
   needing to pull in the libc dependency.

# Build

```
zig build
```
