# chibicc-cil build root repository

[![Japanese language](Images/Japanese.256.png)](README.ja.md)

## What is this?

Thanks for your interest in this project!

This is the build root repository for the project to port Rui Ueyama's [chibicc: A Small C Compiler](https://github.com/rui314/chibicc) to the .NET environment.

I will not be updating this project for a while;
you are welcome to throw out issues and PRs, but there may be no response regarding requests for fixes.

The major remaining issues are left in [the discussion in this repository](https://github.com/kekyo/chibicc-cil-build/discussions).

Of course, you are free to fork and play around with it. At least the project is under MIT distribution as a whole.

## Details

"chibicc" is a C language compiler. When porting it to .NET, a "C runtime library" is required.
But there is no standard implementation in .NET.

Therefore:

1. Build a toolchain "chibicc-cil-toolchain" for use with chibicc.
2. Build chibicc (using the minimal C runtime library "libc-bootstrap" to enable building of chibicc itself).
3. Use the above chibicc to build "newlib", which covers the C runtime library, and the missing implementation "libgloss".
4. Rebuild chibicc using the above completed C runtime libraries "libc.a" and "libgloss.dll".

You will need to run the `build.sh` will do this.

The `build.sh` is written for Ubuntu (22.04/24.04). It will automatically install necessary packages, etc.
If you do not like this behavior, please check the script beforehand (the script should be written in plain language).

## Note

At present, I am about 10 commits away from achieving chibicc porting, but the porting person has abandoned the porting at this point.

* [NGK2025S (Nagoya Joint Reception 2025)](https://ngk.connpass.com/event/334796/) (In japanese)
* [The 9th Center CLR Study Group](https://centerclr.connpass.com/event/341192/) (In japanese)

It may also be available on [YouTube Center CLR channel, chibicc porting list](https://www.youtube.com/playlist?list=PLL43LzwbRhvRL2PkpewoRv0AFVobTtZGt) (TBD / In japanese).

For more details, please refer to the repository of each submodule destination.
