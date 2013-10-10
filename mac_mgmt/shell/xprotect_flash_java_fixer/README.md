xprotect_flash_java_fixer
=========================
modified/combined scripts from rtrouton's repo to fix flash and java using bash

Credit to [Rich Trouton][rich] and [Pepijn Bruienne][pepijn] for original work on this.

I put both of the script's in Rich's repo into one with the intention of using launchd's WatchPaths feature.

I also functionalized the script so that we don't do work we don't need to (simply) if something is not installed.

Also, changing the shell from sh (bash in sh/POSIX compatibility mode but for some reason in OS X a completely seperate binary) to bash and ensuring the use of the [[ command versus the older [ removes several potential errors and makes the entire thing quite a bit safer. Probably the worst of which is shown in this [commit][].

[rich]: https://github.com/rtrouton
[pepijn]: https://github.com/bruienne
[commit]: https://github.com/rmanly/xprotect_flash_java_fixer/commit/56a5f8e7d18994ab1340246594f0df965e6b35e9
