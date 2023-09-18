### CMakeAndroidAapt2CompileDir
* wrapper of "aapt2 compile --dir [resource] -o [oututput]" which is used in the part of android build.
* having internal cache and only execute aapt2 compile if changes are detected.  
```cmake

set(__aapt2 PATH_TO_AAPT2)
set(__rc_dst dst)
set(__rc_libs 
        libs/res-0
        libs/res-1
        libs/res-2)
foreach(__var ${__rc_libs}) 
    CMakeAndroidAapt2CompileDir(
        AAPT2 ${__aapt2}
        DIR ${__var}
        DESTINATION ${__rc_dst} 
        VERBOSE
    )
endforeach()

# will output 
#    dst/res-0.zip
#    dst/res-1.zip
#    dst/res-2.zip

```