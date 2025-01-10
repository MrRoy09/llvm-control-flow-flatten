# Control flow flattening using LLVM pass
A toy program to demonstrate control flow flattening using LLVM passes. Flattens the CFG of each function. If the function has switch statements, run `switchtoif.so` to convert `switch` statements to series of nested `if` and then run `flatten.so`

# Running the pass
Simple compile your program using

``` clang++ -fpass-plugin=./flatten.so ./file.cpp -o main```

# Buidling pass
Compile pass using 

```clang++ -shared -fPIC -o flatten.so flatten.cpp```

# Blog post
I wrote this code for a blog post on introduction to obfuscation using llvm. Find that here:

<a href="https://21verses.blog/2025/01/10/post/"> Control Flow Flattening using LLVM Pass </a>

