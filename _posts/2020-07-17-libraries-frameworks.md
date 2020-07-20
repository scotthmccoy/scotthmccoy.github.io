---
layout: post
title: Libraries & Frameworks
date: 2020-07-17 10:17 -0700
---

# Files, Directories, Packages, Bundles and Frameworks:
A `package` is any directory that the Finder presents to the user as if it were a single file.
Finder considers a directory to be a package if **any** of the following conditions are true:
1. The directory has a known filename extension: .app, .bundle, .framework, .plugin, .kext, and so on.
2. The directory has an extension that some other application claims represents a package type; see Document Packages.
3. The directory has its package bit set.
A `bundle` is type of `package` with a standardized hierarchical structure that holds executable code and the resources used by that code. Apps and `frameworks` are examples of `bundles`.


# Libraries vs Frameworks
* A `Library` is a collection of `object files`
* A `Framework` is a type of `bundle` containing a static or dynamic `library` and its resources.
* So, a `Framework` is a `bundle` (which is also a `package`) that contains a `library` which is a collection of `object files`.

# Object Files, Clang and LLVM
A compiled .m file is outputed by clang as a .o file. These `object files` contain symbols for the linker to piece together into a Mach-O Object File. Like gcc, Clang is a compiler for the c-family of languages and is backed by the LLVM compiler infrastructure which stands for "Low Level Virtual Machine" despite it [not being a Virtual Machine](https://llvm.org/). 

# Mach-O Object Files & Types
Distinct from an `object file` generated by clang, these `Macho-O Object Files` are the various [options for output from Xcode's linker phase](https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/MachOTopics/1-Articles/building_files.html):

![]({{site.url}}/images/mach_o_types.png)





# Static vs Dynamic

| | Static  | Dynamic |
|-|---------|---------|
| Library   | ![]({{site.url}}/images/static_library.png) A **.a** file linked by the Static Linker at compile time. Headers are separate. | ![]({{site.url}}/images/dynamic_library.png) A **.dylib** file linked by the Dynamic Linker, or  `dyld` as-needed at runtime. The advantage is that libraries can be shared and don't take up space in each app. For example, all iOS and macOS system libraries are dynamic. The disadvantage is a slower launch/run time since the linking phase must occur during runtime. |
| Framework | ![]({{site.url}}/images/static_framework.png) A `package` with the **.framework** extension containing a Static Library and its resources. Linked at compile time. | ![]({{site.url}}/images/dynamic_framework.png) A `package` with the **.framework** extension containing a Dynamic Library and its resources. These must either be made available by the operating system (As all iOS and MacOS libraries/frameworks are) or be `embedded` into the App's bundle. |

# Static vs Dynamic Frameworks and Swift
A framework that used swift used to have to be dynamic since they depended on the Swift dylibs. This changed in 


# Other Terms
* *Umbrella Framework* - a framework that contains other frameworks. It is not officially supported on iOS. Normally, when you create a framework which has a dependency, the app is responsible for adding that dependency along with your framework into the project. 
* *Modular Framework* - a framework which contains a .modulemap file inside. Modules can contains submodules. The main advantage is that you save a build time with Modular Framework. Note

https://theswiftdev.com/deep-dive-into-swift-frameworks/
Defines Module
And
Mach-O Type

# Modulemaps

When do you need one and why? I'm pretty sure you only need one for Swift-based frameworks?



# #import versus @import
* Xcode 5 added Modules or "Semantic Import" which is enabled by default. It maps all `#import` and `#include` to use `@import` instead. If clang can find a modulemap with with the same name,  https://stackoverflow.com/questions/18947516/import-vs-import-ios-7
* https://releases.llvm.org/3.3/tools/clang/docs/Modules.html
* https://clang.llvm.org/docs/Modules.html#module-map-language

# Real versus Fake Frameworks
You can safely skip this section as this distinction is no longer of any real significance, Xcode having fixed this bug(?) in 2014 with the release of Xcode 6. 

In disallowing dynamically linked libraries for iOS Apple accidentally(?) removed static iOS framework creation functionality. Developers responded with the "relocatable object file" bundle hack, which tricked Xcode into building something that mostly resembles a framework, but is really a bundle. Alternately, with some tweaking of Xcode itself you could add the ability to create a static iOS framework back into Xcode using this plugin: [iOS-Universal-Framework](https://github.com/kstenerud/iOS-Universal-Framework). 

# The otool and lipo command line tools


# How do you handle code signing?
TODO: add to this section

Embedding dylibs now works (checked with Xcode Version 10.2). Targets -> Frameworks, Libraries and Embedded content.
see https://help.apple.com/xcode/mac/11.0/index.html?localePath=en.lproj#/dev51a648b07
Very good news, because the approach using a build phase has a big problem: code signing happens after all phases ran. So, before that new setting was introduced it could happen that you copied unsigned versions of your libs to the app bundle, which failed the application build, because the app could not be signed.

# Potential Gains from switching to From Dynamic to Static Libs/Frameworks
In an example using 27 frameworks, [this dev](https://medium.com/@acecilia/static-vs-dynamic-frameworks-in-swift-an-in-depth-analysis-ff61a77eec65):
1. **Reduced app size 14.55%**. They theorized this was due to the compiler being able to remove unused symbols which is not possible when using dynamic frameworks, and linked this [heated exchange](https://github.com/ReactiveX/RxSwift/pull/1960) for reference. 
2. **Reduced first-launch load time by about 37.5%**. Subsequent launches were comparable thanks to the dyld cache.


Though the first-launch speed gains are worth pursuing, the size gains should only affect Swift libraries/frameworks since an Objective-C static library aught to be passed to the linker with the -ObjC option specified which "Loads all members of static archive libraries that implement an Objective-C class or category" since one of ObjC's strengths/weaknesses is that it loads the entire symbol table and you can send any message to any object.

From [https://stackoverflow.com/questions/2567498/objective-c-categories-in-static-library](https://stackoverflow.com/questions/2567498/objective-c-categories-in-static-library)
> To resolve this issue, the static library should pass the -ObjC option to the linker. This flag causes the linker to load every object file in the library that defines an Objective-C class or category. While this option will typically result in a larger executable (due to additional object code loaded into the application), it will allow the successful creation of effective Objective-C static libraries that contain categories on existing classes.




