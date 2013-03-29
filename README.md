Zepto conditional loading wrapper
=================================

Merging Zepto with other scripts
------------------------------

Use this wrapper when you need to merge your scripts at build time, and you need Zepto but full-jQuery is not required.

This wrapper optimistically loads Zepto.js inline, but then suppresses its execution and lazily loads jQuery from a CDN (Google Ajax API) if the environment is unsupported.

All versions of Internet Explorer are officially not supported by Zepto. Unfortunately, IE8 and earlier throw exceptions if it is even loaded.

Environment
-----------

This is just a simple bash script and has only really been tested on Mac OS X using Homebrew for Node.
In other environments, YMMV. Commented out is a test/auto-install for Node.js/NPM.
Ideally, I'd put it into something more portable, or use Zepto's setup, but this did the trick for me.
As it is, the README is larger than the script.

Alternate jQuery CDN
--------------------

If you want to modify where jQuery is loaded from, just tweak [`unsupported.js`](https://github.com/mckamey/zepto-wrapper/blob/master/src/unsupported.js#files). It should be easy to find.

Custom Modules
--------------

If you want a different set of build modules than the default Zepto builds, just edit the `MODULES` varible in [`build.sh`](https://github.com/mckamey/zepto-wrapper/blob/master/build.sh#files). For example, I prefer to remove `detect` and `fx`.

By default these are the included modules:

- [**intro**](https://github.com/mckamey/zepto-wrapper/blob/master/build.sh#files) - start of the wrapper
- [**unsupported**](https://github.com/mckamey/zepto-wrapper/blob/master/src/unsupported.js#files) - supported test and jQuery lazy loader
- [**polyfill**](https://github.com/madrobby/zepto)
- [**zepto**](https://github.com/madrobby/zepto)
- [**detect**](https://github.com/madrobby/zepto)
- [**event**](https://github.com/madrobby/zepto)
- [**ajax**](https://github.com/madrobby/zepto)
- [**form**](https://github.com/madrobby/zepto)
- [**fx**](https://github.com/madrobby/zepto)
- [**outro**](https://github.com/mckamey/zepto-wrapper/blob/master/build.sh#files) - end of the wrapper

Minification
------------

I prefer to use minification / obfuscation mechanisms, so I don't bother to keep my variables short or hang onto `zepto.min.js`.
If you subscribe to idiomatic Zepto formatting, you probably won't like my work.
Feel free to tweak to your needs, just don't expect me to accept a pull request to remove semicolons, etc.

License
-------

Zepto-wrapper is licensed under the terms of the MIT License.
