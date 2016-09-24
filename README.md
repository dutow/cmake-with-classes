CMake with classes
===

Implements basic class support for CMake.

Motivation
---

CMake has a simple script language without advanced abstraction features. 
Without classes and virtual/dynamic function calls complex buildscripts usually end up with long if-chains in their lower levels, resulting in unmaintanable code.

CMake with classes tries to fix some of these issues by simulating these language constructs in a readable manner using purely standard CMake features.

### Virtual calls

One of the most recurring problems in cross platform CMake programs is the management of different compiler flags. 
Classes could make this easier by providing a standard interface for different compilers:

```cmake
CREATE_INSTANCE(CXX_HELPER, "${CMAKE_CXX_COMPILER_ID}_HELPER")
CXX_HELPER_ENABLE_ALL_WARNINGS()
CXX_HELPER_TREAT_WARNINGS_AS_ERRORS()
CXX_HELPER_SET_STANDARD(14)
```

### Dynamic instance selection (TODO)

Sometimes it's useful to dynamically select the underlying object instead of hardwiring the instance name.

For example we might want to set some flags for both the C++ and the C compiler.

Because CMake doesn't allow dynamic method names, we can accomplish this by passing CXX_HELPER (the instance name) as a parameter.

```cmake
CREATE_INSTANCE(CXX_HELPER, "${CMAKE_CXX_COMPILER_ID}_HELPER")
COMP_HELPER_ENABLE_ALL_WARNINGS(CXX_HELPER)
COMP_HELPER_TREAT_WARNINGS_AS_ERRORS()
COMP_HELPER_SET_STANDARD(CXX_HELPER, 14)
```

In this example `COMP_HELPER` is the baseclass (interface) of the specific compiler helpers.

More examples
---

See the `tests` directory, which contains many simple programs.

