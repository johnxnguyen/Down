## Down
[![Coverage Status](https://coveralls.io/repos/github/iwasrobbed/Down/badge.svg?branch=master)](https://coveralls.io/github/iwasrobbed/Down?branch=master)
[![Build Status](https://travis-ci.org/iwasrobbed/Down.svg?branch=master)](https://travis-ci.org/iwasrobbed/Down)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/iwasrobbed/Down/blob/master/LICENSE)
[![CocoaPods](https://img.shields.io/cocoapods/v/Down.svg?maxAge=2592000)]()
[![Swift](https://img.shields.io/badge/language-Swift-blue.svg)](https://swift.org)

Blazing fast Markdown rendering in Swift, built upon [cmark](https://github.com/jgm/cmark).

Is your app using it? [Let me know!](mailto:rob@desideratalabs.co)

### Installation

Quickly install using [CocoaPods](https://cocoapods.org): 

```ruby
pod 'Down'
```

### Robust Performance

>[cmark](https://github.com/jgm/cmark) can render a Markdown version of War and Peace in the blink of an eye (127 milliseconds on a ten year old laptop, vs. 100-400 milliseconds for an eye blink). In our [benchmarks](https://github.com/jgm/cmark/blob/master/benchmarks.md), cmark is 10,000 times faster than the original Markdown.pl, and on par with the very fastest available Markdown processors.

> The library has been extensively fuzz-tested using [american fuzzy lop](http://lcamtuf.coredump.cx/afl). The test suite includes pathological cases that bring many other Markdown parsers to a crawl (for example, thousands-deep nested bracketed text or block quotes).

### Output Formats
* HTML
* XML

### API


### Supports
Swift, ARC & iOS 8+

### Markdown Specification

Down is built upon the [CommonMark](http://commonmark.org) specification.

### A little help from my friends
Please feel free to fork and create a pull request for bug fixes or improvements, being sure to maintain the general coding style, adding tests, and adding comments as necessary.

### Credit
This library is a wrapper around [cmark](https://github.com/jgm/cmark), which is built upon the [CommonMark](http://commonmark.org) Markdown specification. 

[cmark](https://github.com/jgm/cmark) is Copyright (c) 2014, John MacFarlane. View [full license](https://github.com/jgm/cmark/blob/master/COPYING).