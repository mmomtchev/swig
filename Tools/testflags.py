#!/usr/bin/env python3

def get_cflags(language, std, compiler):
    if std == None or len(std) == 0:
        std = "gnu89"
    c_common = "-fdiagnostics-show-option -std=" + std + " -Wno-long-long -Wreturn-type -Wmissing-field-initializers -Wunused-variable"
    if std == "gnu89" or std == "gnu90":
        # gnu89 standard allows declaration after headers
        # use c99 or gnu99 if feature is necessary for using target language
        c_common = c_common + " -Wdeclaration-after-statement"
    cflags = {
             "c":"-Werror " + c_common,
        "csharp":"-Werror " + c_common,
             "d":"-Werror " + c_common,
            "go":"-Werror " + c_common + " -Wno-unused-variable",
         "guile":"-Werror " + c_common,
          "java":"-Werror " + c_common,
    "javascript":"-Werror " + c_common + " -Wno-unused-variable -Wno-unused-function",
           "lua":"-Werror " + c_common,
         "ocaml":"-Werror " + c_common,
        "octave":"-Werror " + c_common,
         "perl5":"-Werror " + c_common,
           "php":"-Werror " + c_common,
        "python":"-Werror " + c_common,
             "r":"-Werror " + c_common,
          "ruby":"-Werror " + c_common,
        "scilab":"-Werror " + c_common + " -Wno-unused-variable",
           "tcl":"-Werror " + c_common,
    }
    if compiler == "clang":
        cflags["guile"] += " -Wno-attributes" # -Wno-attributes is for clang LLVM 3.5 and bdw-gc < 7.5 used by guile

    if language not in cflags:
        raise RuntimeError("{} is not a supported language".format(language))

    return cflags[language]

def get_cxxflags(language, std, compiler):
    if std == None or len(std) == 0:
        std = "c++98"
    cxx_common = "-fdiagnostics-show-option -std=" + std + " -Wno-long-long -Wreturn-type -Wmissing-field-initializers -Wunused-variable"
    cxxflags = {
             "c":"-Werror " + cxx_common,
        "csharp":"-Werror " + cxx_common,
             "d":"-Werror " + cxx_common,
            "go":"-Werror " + cxx_common + " -Wno-unused-variable",
         "guile":"-Werror " + cxx_common,
          "java":"-Werror " + cxx_common,
    "javascript":"-Werror " + cxx_common + " -Wno-unused-variable -Wno-unused-function",
           "lua":"-Werror " + cxx_common,
         "ocaml":"-Werror " + cxx_common,
        "octave":"-Werror " + cxx_common,
         "perl5":"-Werror " + cxx_common,
           "php":"-Werror " + cxx_common,
        "python":"-Werror " + cxx_common,
             "r":"-Werror " + cxx_common,
          "ruby":"-Werror " + cxx_common + " -Wno-deprecated-declarations", # For Ruby on MacOS Xcode 9.4 misconfiguration defining 'isfinite' to deprecated 'finite'
        "scilab":"-Werror " + cxx_common + " -Wno-unused-variable",
           "tcl":"-Werror " + cxx_common,
    }
    if compiler == "clang":
        cxxflags["guile"] += " -Wno-attributes" # -Wno-attributes is for clang LLVM 3.5 and bdw-gc < 7.5 used by guile

    if language not in cxxflags:
        raise RuntimeError("{} is not a supported language".format(language))

    return cxxflags[language]

import argparse
parser = argparse.ArgumentParser(description="Display CFLAGS or CXXFLAGS to use for testing the SWIG examples and test-suite.")
parser.add_argument("-l", "--language", required=True, help="set language to show flags for")
flags = parser.add_mutually_exclusive_group(required=True)
flags.add_argument("-c", "--cflags", action="store_true", default=False, help="show CFLAGS")
flags.add_argument("-x", "--cxxflags", action="store_true", default=False, help="show CXXFLAGS")
parser.add_argument("-s", "--std", required=False, help="language standard flags for the -std= option")
parser.add_argument("-C", "--compiler", required=False, help="compiler used (clang or gcc)")
args = parser.parse_args()

if args.cflags:
    get_flags = get_cflags
elif args.cxxflags:
    get_flags = get_cxxflags
else:
    parser.print_help()
    exit(1)

print(get_flags(args.language, args.std, args.compiler))
