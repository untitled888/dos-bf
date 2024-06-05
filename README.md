# dos-bf

This is a simple Brainfuck interpreter for DOS able to detect syntax errors. It is prebuilt with the maximum program length and the maximum tape length equal to 5000.

[Download interpreter](https://github.com/untitled888/dos-bf/releases/tag/1.0.0)

### Usage

```
dos-bf.exe [filename]
```

### Build instructions

dos-bf may be built with FreeBASIC:
```
fbc.exe dos-bf.bas
```
You can change the constants `MAX_PROG_LEN` and `MAX_TAPE_LEN` at the beginning of the source file in order to increase the maximum program length and the maximum tape length respectively.

Have fun!