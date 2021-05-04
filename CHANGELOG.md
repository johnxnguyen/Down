# Changelog

## [v0.11.0](https://github.com/johnxnguyen/Down/tree/v0.11.0) (2021-05-04)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.10.0...v0.11.0)

**Implemented enhancements:**

- \[CodeCoverage\] Improve accuracy for combined code coverage reporting [\#205](https://github.com/johnxnguyen/Down/issues/205)

**Closed issues:**

- DownStyler not included when installed via CocoaPods [\#254](https://github.com/johnxnguyen/Down/issues/254)
- \[Commonmark\] Strikethrough not working / not supported [\#253](https://github.com/johnxnguyen/Down/issues/253)
- \[Attributed Strings\] Unordered list items with a single line appear further indented than those with multiple lines when using a custom font [\#246](https://github.com/johnxnguyen/Down/issues/246)

**Merged pull requests:**

- \[Feature\] Custom list prefixes for AttributedStringVisitor [\#255](https://github.com/johnxnguyen/Down/pull/255) ([dloic](https://github.com/dloic))
- \[Chore\] Add SwiftLint [\#252](https://github.com/johnxnguyen/Down/pull/252) ([johnxnguyen](https://github.com/johnxnguyen))
- \[Chore\] Fix codecov report [\#251](https://github.com/johnxnguyen/Down/pull/251) ([johnxnguyen](https://github.com/johnxnguyen))

## [v0.10.0](https://github.com/johnxnguyen/Down/tree/v0.10.0) (2021-02-28)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.9.5...v0.10.0)

**Closed issues:**

- Does not build in 12.5 [\#244](https://github.com/johnxnguyen/Down/issues/244)
- \[Crash\] Missing resource bundle when using SPM [\#243](https://github.com/johnxnguyen/Down/issues/243)

**Merged pull requests:**

- \[Improvement\] Expose DownTextView's designated initializer [\#250](https://github.com/johnxnguyen/Down/pull/250) ([max-potapov](https://github.com/max-potapov))
- \[Chore\] Add arm64 as valid arch when building for simulator on M1 macs [\#249](https://github.com/johnxnguyen/Down/pull/249) ([michaelknoch](https://github.com/michaelknoch))
- \[Chore\] Reorganize project structure for SPM [\#248](https://github.com/johnxnguyen/Down/pull/248) ([johnxnguyen](https://github.com/johnxnguyen))
- \[Chore\] Use SPM to manage snapshot testing dependency [\#247](https://github.com/johnxnguyen/Down/pull/247) ([johnxnguyen](https://github.com/johnxnguyen))

## [v0.9.5](https://github.com/johnxnguyen/Down/tree/v0.9.5) (2021-02-12)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.9.4...v0.9.5)

**Closed issues:**

- Namespacing issues with Down "Node" type [\#242](https://github.com/johnxnguyen/Down/issues/242)
- GitHub actions build failure: `small method list` [\#238](https://github.com/johnxnguyen/Down/issues/238)

**Merged pull requests:**

- \[Fix\] Compilation failure with Xcode 12.5 and SPM [\#245](https://github.com/johnxnguyen/Down/pull/245) ([claurel](https://github.com/claurel))
- \[Chore\] Update readme [\#237](https://github.com/johnxnguyen/Down/pull/237) ([johnxnguyen](https://github.com/johnxnguyen))

## [v0.9.4](https://github.com/johnxnguyen/Down/tree/v0.9.4) (2020-10-21)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.9.3...v0.9.4)

**Implemented enhancements:**

- Create custom sequence to access child nodes [\#228](https://github.com/johnxnguyen/Down/pull/228) ([5sw](https://github.com/5sw))

**Closed issues:**

- DownStylerConfiguration Link Color Not Working [\#232](https://github.com/johnxnguyen/Down/issues/232)
- SwiftUI support [\#231](https://github.com/johnxnguyen/Down/issues/231)
- How to pre-calculate height needed for attributed string when using DownLayoutManager [\#226](https://github.com/johnxnguyen/Down/issues/226)
- How i can render both markdown and Latex  ? [\#221](https://github.com/johnxnguyen/Down/issues/221)
- Emphasis + Strong [\#220](https://github.com/johnxnguyen/Down/issues/220)
- \[StackOverflow\] Creating a new Visitor leads to wrapping value error [\#218](https://github.com/johnxnguyen/Down/issues/218)
- 0.9.0/0.9.1 don't build with Swift 5.0.x [\#217](https://github.com/johnxnguyen/Down/issues/217)
- Unable to build Swift package in Xcode 11.4.1 [\#209](https://github.com/johnxnguyen/Down/issues/209)
- \[Feature\] Add support for Mac Catalyst [\#208](https://github.com/johnxnguyen/Down/issues/208)

**Merged pull requests:**

- \[Fix\] DownTextView renders incorrect link color [\#233](https://github.com/johnxnguyen/Down/pull/233) ([johnxnguyen](https://github.com/johnxnguyen))
- Added instructions for using the Swift Package Manager [\#230](https://github.com/johnxnguyen/Down/pull/230) ([klm1](https://github.com/klm1))
- Use case let as instead of case is and force casting later. [\#227](https://github.com/johnxnguyen/Down/pull/227) ([5sw](https://github.com/5sw))
- Add macOS arm64 platform [\#224](https://github.com/johnxnguyen/Down/pull/224) ([jasminlapalme](https://github.com/jasminlapalme))

## [v0.9.3](https://github.com/johnxnguyen/Down/tree/v0.9.3) (2020-06-12)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.9.2...v0.9.3)

**Closed issues:**

- Line breaks between list items are not parsed correctly [\#214](https://github.com/johnxnguyen/Down/issues/214)
- Can't build with copied sources [\#211](https://github.com/johnxnguyen/Down/issues/211)
- hard blank line insertion after list [\#210](https://github.com/johnxnguyen/Down/issues/210)
- Cocoapod version 0.9.2 not available. [\#206](https://github.com/johnxnguyen/Down/issues/206)
- \[Feature\] Local images not accessible from WKWebView [\#198](https://github.com/johnxnguyen/Down/issues/198)

**Merged pull requests:**

- \[Chore\] Bump swift snapshot testing to 1.7.2 [\#216](https://github.com/johnxnguyen/Down/pull/216) ([johnxnguyen](https://github.com/johnxnguyen))
- Add tightness property to List node [\#215](https://github.com/johnxnguyen/Down/pull/215) ([johnxnguyen](https://github.com/johnxnguyen))
- Add styling options for level 4 to 6 headings [\#207](https://github.com/johnxnguyen/Down/pull/207) ([mathebox](https://github.com/mathebox))
- \[DownView\] Add parameter so bundle is writable [\#200](https://github.com/johnxnguyen/Down/pull/200) ([brunnobga](https://github.com/brunnobga))

## [v0.9.2](https://github.com/johnxnguyen/Down/tree/v0.9.2) (2020-03-03)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.9.1...v0.9.2)

**Closed issues:**

- Update Framework with Swift 5.1 [\#178](https://github.com/johnxnguyen/Down/issues/178)

**Merged pull requests:**

- Swift 5.1 Support [\#204](https://github.com/johnxnguyen/Down/pull/204) ([ghost](https://github.com/ghost))
- Resolves Swift Package Manager issue related to swift-snapshot-testing [\#203](https://github.com/johnxnguyen/Down/pull/203) ([ghost](https://github.com/ghost))

## [v0.9.1](https://github.com/johnxnguyen/Down/tree/v0.9.1) (2020-02-28)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.9.0...v0.9.1)

**Implemented enhancements:**

- Added Linux support. [\#172](https://github.com/johnxnguyen/Down/pull/172) ([vgorloff](https://github.com/vgorloff))

**Closed issues:**

- SwiftPM : Resolve apparent version incompatibility with swift-snapshot-testing [\#202](https://github.com/johnxnguyen/Down/issues/202)
- Release fixes made after 0.9.0 [\#201](https://github.com/johnxnguyen/Down/issues/201)
- Swift UI Support [\#199](https://github.com/johnxnguyen/Down/issues/199)
- 'BaseNode' initializer is inaccessible due to 'internal' protection level [\#196](https://github.com/johnxnguyen/Down/issues/196)
- Any emoji support? [\#195](https://github.com/johnxnguyen/Down/issues/195)
- Swift Packege maneger? [\#194](https://github.com/johnxnguyen/Down/issues/194)
- Regression: single newline syntax not working \(any variety\) [\#191](https://github.com/johnxnguyen/Down/issues/191)
- Down cannot convert this markdown string to html [\#190](https://github.com/johnxnguyen/Down/issues/190)
- App using xcframework with Down pod dependency causes crash [\#187](https://github.com/johnxnguyen/Down/issues/187)
- Is the text supposed to be rendering this large? [\#186](https://github.com/johnxnguyen/Down/issues/186)
- Issue with markdown render/convert to attribute string on macOS latest version [\#185](https://github.com/johnxnguyen/Down/issues/185)
- Table are not render [\#183](https://github.com/johnxnguyen/Down/issues/183)
- How to change text color? [\#182](https://github.com/johnxnguyen/Down/issues/182)
- incorrect parse for string that is a mixture of markdown and html [\#180](https://github.com/johnxnguyen/Down/issues/180)

**Merged pull requests:**

- Improve configurability of DownStyler [\#188](https://github.com/johnxnguyen/Down/pull/188) ([mgacy](https://github.com/mgacy))
- Make color & font collection initializers public [\#184](https://github.com/johnxnguyen/Down/pull/184) ([johnxnguyen](https://github.com/johnxnguyen))

## [v0.9.0](https://github.com/johnxnguyen/Down/tree/v0.9.0) (2019-10-06)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.8.6...v0.9.0)

**Closed issues:**

- Please add Styler example in the documentation [\#179](https://github.com/johnxnguyen/Down/issues/179)
- \[Attributed Strings\] Can the `Styler` know which list item marker was parsed? [\#176](https://github.com/johnxnguyen/Down/issues/176)
- Error: 'cmark\_export.h' file not found with \<angled\> include; use "quotes" instead [\#175](https://github.com/johnxnguyen/Down/issues/175)
- GIFF Support [\#174](https://github.com/johnxnguyen/Down/issues/174)
- Help: Set Default Font [\#168](https://github.com/johnxnguyen/Down/issues/168)
- \[Testing\] Adding a snapshot testing framework [\#165](https://github.com/johnxnguyen/Down/issues/165)
- Adding a snapshot test framework [\#164](https://github.com/johnxnguyen/Down/issues/164)
- XCode Beta 4 Build Error [\#162](https://github.com/johnxnguyen/Down/issues/162)
- \[Attributed Strings\] Create default `Styler` for attributed string rendering [\#138](https://github.com/johnxnguyen/Down/issues/138)
- \[Help out\] Collaborators wanted! Help us improve Down [\#105](https://github.com/johnxnguyen/Down/issues/105)
- \[DownView\] Support for internal links? [\#93](https://github.com/johnxnguyen/Down/issues/93)

**Merged pull requests:**

- \[Feature\] Create default `Styler` for attributed string rendering [\#177](https://github.com/johnxnguyen/Down/pull/177) ([johnxnguyen](https://github.com/johnxnguyen))
- Resolve xcode11beta4 issue. [\#170](https://github.com/johnxnguyen/Down/pull/170) ([ykphuah](https://github.com/ykphuah))
- Minor documentation fix [\#169](https://github.com/johnxnguyen/Down/pull/169) ([nighthawk](https://github.com/nighthawk))

## [v0.8.6](https://github.com/johnxnguyen/Down/tree/v0.8.6) (2019-07-11)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.8.5...v0.8.6)

**Closed issues:**

- Update Options to support Unsafe Rendering [\#159](https://github.com/johnxnguyen/Down/issues/159)
- .toAttributedString stylesheet parameter [\#158](https://github.com/johnxnguyen/Down/issues/158)

**Merged pull requests:**

- Updates for unsafe option [\#160](https://github.com/johnxnguyen/Down/pull/160) ([hbowie](https://github.com/hbowie))
- Fix permissions error on Catalina beta 2 [\#156](https://github.com/johnxnguyen/Down/pull/156) ([mdiep](https://github.com/mdiep))

## [v0.8.5](https://github.com/johnxnguyen/Down/tree/v0.8.5) (2019-06-13)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.8.4...v0.8.5)

**Closed issues:**

- DebugVisitor is missing a public initializer [\#152](https://github.com/johnxnguyen/Down/issues/152)
- Can't build with Swift 5.1 with SwiftPM [\#151](https://github.com/johnxnguyen/Down/issues/151)

**Merged pull requests:**

- \[SPM\] Fixes error with missing headers [\#154](https://github.com/johnxnguyen/Down/pull/154) ([aasimk2000](https://github.com/aasimk2000))
- Create Public Initializer for DebugVisitor [\#153](https://github.com/johnxnguyen/Down/pull/153) ([mfcollins3](https://github.com/mfcollins3))

## [v0.8.4](https://github.com/johnxnguyen/Down/tree/v0.8.4) (2019-06-04)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.8.3...v0.8.4)

**Closed issues:**

- \[Carthage\] Missing required module 'libcmark' [\#120](https://github.com/johnxnguyen/Down/issues/120)

**Merged pull requests:**

- Add Swift Package Manager support [\#150](https://github.com/johnxnguyen/Down/pull/150) ([aasimk2000](https://github.com/aasimk2000))
- \[AST\] Replace line separator with paragraph separator. [\#149](https://github.com/johnxnguyen/Down/pull/149) ([fgulan](https://github.com/fgulan))

## [v0.8.3](https://github.com/johnxnguyen/Down/tree/v0.8.3) (2019-05-15)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.8.2...v0.8.3)

**Closed issues:**

- Pass DownOptions to DownView [\#147](https://github.com/johnxnguyen/Down/issues/147)

**Merged pull requests:**

- Feature - pass DownOptions to init and update [\#148](https://github.com/johnxnguyen/Down/pull/148) ([ladislas](https://github.com/ladislas))

## [v0.8.2](https://github.com/johnxnguyen/Down/tree/v0.8.2) (2019-05-10)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.8.1...v0.8.2)

**Merged pull requests:**

- Mark as safe for app extension use. [\#146](https://github.com/johnxnguyen/Down/pull/146) ([sgoodwin](https://github.com/sgoodwin))

## [v0.8.1](https://github.com/johnxnguyen/Down/tree/v0.8.1) (2019-04-26)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.8.0...v0.8.1)

**Merged pull requests:**

- \[Swift\] Update to Swift 5.0 [\#145](https://github.com/johnxnguyen/Down/pull/145) ([iwasrobbed](https://github.com/iwasrobbed))

## [v0.8.0](https://github.com/johnxnguyen/Down/tree/v0.8.0) (2019-04-24)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.7.0...v0.8.0)

**Closed issues:**

- 0.7.0 problems with NSAttributedString.Key [\#139](https://github.com/johnxnguyen/Down/issues/139)

**Merged pull requests:**

- \[Down\] Add new `unsafe` option [\#143](https://github.com/johnxnguyen/Down/pull/143) ([iwasrobbed](https://github.com/iwasrobbed))
- Bump cmark to 0.29.0 [\#142](https://github.com/johnxnguyen/Down/pull/142) ([larryonoff](https://github.com/larryonoff))

## [v0.7.0](https://github.com/johnxnguyen/Down/tree/v0.7.0) (2019-04-24)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.6.6...v0.7.0)

**Implemented enhancements:**

- \[Documentation\] AST API [\#134](https://github.com/johnxnguyen/Down/issues/134)
- \[Attributed Strings\] Line spacing more than expected [\#121](https://github.com/johnxnguyen/Down/issues/121)
- \[Down\] Rendering to attributed string is really slow, requires main thread [\#100](https://github.com/johnxnguyen/Down/issues/100)

**Merged pull requests:**

- Set Swift version 4.0 in podspec [\#140](https://github.com/johnxnguyen/Down/pull/140) ([larryonoff](https://github.com/larryonoff))
- \[Cleanup\] Comment docs, example apps, and whitespace [\#136](https://github.com/johnxnguyen/Down/pull/136) ([iwasrobbed](https://github.com/iwasrobbed))
- \[Feature\] Create API for parsing to AST and NSAttributedString [\#132](https://github.com/johnxnguyen/Down/pull/132) ([johnxnguyen](https://github.com/johnxnguyen))

## [v0.6.6](https://github.com/johnxnguyen/Down/tree/v0.6.6) (2019-04-11)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.6.5...v0.6.6)

**Closed issues:**

- Swift 4/5 compatibility [\#131](https://github.com/johnxnguyen/Down/issues/131)

**Merged pull requests:**

- Wrap openURL so that Down compiles in app extensions [\#133](https://github.com/johnxnguyen/Down/pull/133) ([nheagy](https://github.com/nheagy))

## [v0.6.5](https://github.com/johnxnguyen/Down/tree/v0.6.5) (2019-04-02)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.6.4...v0.6.5)

**Merged pull requests:**

- Fix Xcode 10.2 warnings [\#130](https://github.com/johnxnguyen/Down/pull/130) ([mdiep](https://github.com/mdiep))

## [v0.6.4](https://github.com/johnxnguyen/Down/tree/v0.6.4) (2019-03-30)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.6.3...v0.6.4)

**Closed issues:**

- Support SwiftPM [\#128](https://github.com/johnxnguyen/Down/issues/128)
- \[DownView\] Load multiple .md files \(link support\) [\#68](https://github.com/johnxnguyen/Down/issues/68)

**Merged pull requests:**

- Fix Swift module errors when used alongside Firestore [\#125](https://github.com/johnxnguyen/Down/pull/125) ([vzsg](https://github.com/vzsg))

## [v0.6.3](https://github.com/johnxnguyen/Down/tree/v0.6.3) (2019-03-27)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.6.2...v0.6.3)

**Implemented enhancements:**

- \[DownView\] Doesn't reflow text on orientation change [\#111](https://github.com/johnxnguyen/Down/issues/111)

**Fixed bugs:**

- Crash rendering markdown [\#126](https://github.com/johnxnguyen/Down/issues/126)

**Closed issues:**

- Cocoapods: libcmark [\#124](https://github.com/johnxnguyen/Down/issues/124)
- Use with storyboards [\#123](https://github.com/johnxnguyen/Down/issues/123)
- support for audio markdown? [\#122](https://github.com/johnxnguyen/Down/issues/122)
- \[Down\] Can't render toAttributedString while app is in background [\#116](https://github.com/johnxnguyen/Down/issues/116)

**Merged pull requests:**

- Fix crash from missing parser.h include [\#129](https://github.com/johnxnguyen/Down/pull/129) ([phoney](https://github.com/phoney))
- Make the DownView reflow text on device rotation [\#127](https://github.com/johnxnguyen/Down/pull/127) ([phoney](https://github.com/phoney))

## [v0.6.2](https://github.com/johnxnguyen/Down/tree/v0.6.2) (2018-11-28)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.6.1...v0.6.2)

**Implemented enhancements:**

- \[cmark\] Some characters are escaped twice [\#99](https://github.com/johnxnguyen/Down/issues/99)

**Merged pull requests:**

- Add compiler flag to suppress implicit conversion warnings [\#118](https://github.com/johnxnguyen/Down/pull/118) ([phoney](https://github.com/phoney))

## [v0.6.1](https://github.com/johnxnguyen/Down/tree/v0.6.1) (2018-11-23)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.6.0...v0.6.1)

**Closed issues:**

- 2 Swift Compiler Errors when installing Down on iOS [\#117](https://github.com/johnxnguyen/Down/issues/117)
- How to update to the latest version of the cmark library [\#115](https://github.com/johnxnguyen/Down/issues/115)

**Merged pull requests:**

- \[travis\] Update to retry [\#114](https://github.com/johnxnguyen/Down/pull/114) ([iwasrobbed](https://github.com/iwasrobbed))
- Fix macOS Platform, Custom URL Scheme Handler, Polish Demos. [\#110](https://github.com/johnxnguyen/Down/pull/110) ([chriszielinski](https://github.com/chriszielinski))

## [v0.6.0](https://github.com/johnxnguyen/Down/tree/v0.6.0) (2018-11-10)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.5.3...v0.6.0)

**Implemented enhancements:**

- \[iOS 10+\] Warnings for WebKit signal service and latex.c [\#94](https://github.com/johnxnguyen/Down/issues/94)
- Update cmark version to latest stable release [\#84](https://github.com/johnxnguyen/Down/issues/84)

**Closed issues:**

- HTML to Markdowndow? [\#107](https://github.com/johnxnguyen/Down/issues/107)
- Blockquote does not work in NSAttributedString [\#106](https://github.com/johnxnguyen/Down/issues/106)
- Support for Dynamic Type [\#90](https://github.com/johnxnguyen/Down/issues/90)

**Merged pull requests:**

- \[Down\] Bump to v0.6.0 [\#113](https://github.com/johnxnguyen/Down/pull/113) ([iwasrobbed](https://github.com/iwasrobbed))
- \[cmark\] Update lib to v0.28.3 [\#112](https://github.com/johnxnguyen/Down/pull/112) ([phoney](https://github.com/phoney))
- Update project to Xcode 10 [\#109](https://github.com/johnxnguyen/Down/pull/109) ([funkyboy](https://github.com/funkyboy))

## [v0.5.3](https://github.com/johnxnguyen/Down/tree/v0.5.3) (2018-09-19)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.5.2...v0.5.3)

**Implemented enhancements:**

- &rdquo; not being rendered [\#95](https://github.com/johnxnguyen/Down/issues/95)
- Update issue templates [\#101](https://github.com/johnxnguyen/Down/pull/101) ([iwasrobbed](https://github.com/iwasrobbed))

**Fixed bugs:**

- \[Xcode 10\] Crash in XCBuildService; need to use old build system [\#91](https://github.com/johnxnguyen/Down/issues/91)

**Closed issues:**

- DownView font size on iPad is huge [\#102](https://github.com/johnxnguyen/Down/issues/102)
- Is there a way to convert NSAttributedString back to markdown? [\#98](https://github.com/johnxnguyen/Down/issues/98)
- Back Gesture [\#96](https://github.com/johnxnguyen/Down/issues/96)
- Access for  [\#92](https://github.com/johnxnguyen/Down/issues/92)
- Image size NSAttributedString [\#89](https://github.com/johnxnguyen/Down/issues/89)
- Dependency analysis warnings with Cocoapods [\#88](https://github.com/johnxnguyen/Down/issues/88)
- WatchKit Support [\#71](https://github.com/johnxnguyen/Down/issues/71)
- Installation via Swift Package Manager [\#61](https://github.com/johnxnguyen/Down/issues/61)

**Merged pull requests:**

- \[Xcode 10\]\[Carthage\] Use new build system [\#104](https://github.com/johnxnguyen/Down/pull/104) ([torokzsolt](https://github.com/torokzsolt))
- Updates the project settings to use the Legacy Build System. [\#97](https://github.com/johnxnguyen/Down/pull/97) ([pieromattos](https://github.com/pieromattos))
- \[Release\] v0.5.2 [\#87](https://github.com/johnxnguyen/Down/pull/87) ([iwasrobbed](https://github.com/iwasrobbed))

## [v0.5.2](https://github.com/johnxnguyen/Down/tree/v0.5.2) (2018-05-05)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.5.1...v0.5.2)

**Merged pull requests:**

- \[Pods\] Only include files in source\_files that can be compiled [\#86](https://github.com/johnxnguyen/Down/pull/86) ([njdehoog](https://github.com/njdehoog))

## [v0.5.1](https://github.com/johnxnguyen/Down/tree/v0.5.1) (2018-03-03)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.5.0...v0.5.1)

**Closed issues:**

- `DocumentReadingOptionKey` Error via pod [\#80](https://github.com/johnxnguyen/Down/issues/80)

**Merged pull requests:**

- Add optional stylesheet argument for NSAttributedString renderer [\#79](https://github.com/johnxnguyen/Down/pull/79) ([kengruven](https://github.com/kengruven))
- Roll up cmark's COPYING sections into the top-level LICENSE file [\#78](https://github.com/johnxnguyen/Down/pull/78) ([kengruven](https://github.com/kengruven))
- Update supported versions in README [\#77](https://github.com/johnxnguyen/Down/pull/77) ([kengruven](https://github.com/kengruven))

## [v0.5.0](https://github.com/johnxnguyen/Down/tree/v0.5.0) (2018-02-24)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.4.2...v0.5.0)

**Implemented enhancements:**

- Fix/update example app [\#58](https://github.com/johnxnguyen/Down/pull/58) ([iwasrobbed](https://github.com/iwasrobbed))

**Fixed bugs:**

- Building for tvOS fails [\#49](https://github.com/johnxnguyen/Down/issues/49)
- Fix Carthage builds [\#72](https://github.com/johnxnguyen/Down/pull/72) ([tonyarnold](https://github.com/tonyarnold))

**Closed issues:**

- Swift 3+ convention for capitalization [\#74](https://github.com/johnxnguyen/Down/issues/74)
- macOS 10.11 support? [\#73](https://github.com/johnxnguyen/Down/issues/73)
- Installing with Carthage for Mac fails [\#70](https://github.com/johnxnguyen/Down/issues/70)
- Error building/installing Down [\#69](https://github.com/johnxnguyen/Down/issues/69)
- get heigth when add downview to other view? [\#67](https://github.com/johnxnguyen/Down/issues/67)
- iOS8 crash [\#66](https://github.com/johnxnguyen/Down/issues/66)
- Image caching [\#65](https://github.com/johnxnguyen/Down/issues/65)
- Some warnings to fix [\#64](https://github.com/johnxnguyen/Down/issues/64)
- build error [\#63](https://github.com/johnxnguyen/Down/issues/63)
- Lists and paragraph spacing [\#62](https://github.com/johnxnguyen/Down/issues/62)
- Converting Markdown string to HTML with emojis [\#60](https://github.com/johnxnguyen/Down/issues/60)
- Syntax highlighting themes [\#59](https://github.com/johnxnguyen/Down/issues/59)
- Compiling error on example project [\#57](https://github.com/johnxnguyen/Down/issues/57)
- Compilation error using Carthage [\#54](https://github.com/johnxnguyen/Down/issues/54)

**Merged pull requests:**

- Use lower-case Swift 3 convention for DownOptions [\#76](https://github.com/johnxnguyen/Down/pull/76) ([kengruven](https://github.com/kengruven))
- Lower MACOSX\_DEPLOYMENT\_TARGET to include El Capitan [\#75](https://github.com/johnxnguyen/Down/pull/75) ([kengruven](https://github.com/kengruven))
- WebKit not available on watchOS. [\#56](https://github.com/johnxnguyen/Down/pull/56) ([128keaton](https://github.com/128keaton))
- Update README.md [\#55](https://github.com/johnxnguyen/Down/pull/55) ([128keaton](https://github.com/128keaton))
- Updated Copyright year in ReadMe file [\#53](https://github.com/johnxnguyen/Down/pull/53) ([jobinsjohn](https://github.com/jobinsjohn))

## [v0.4.2](https://github.com/johnxnguyen/Down/tree/v0.4.2) (2017-10-21)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.4.1...v0.4.2)

**Closed issues:**

- Push v0.4.1 to cocoapods  [\#51](https://github.com/johnxnguyen/Down/issues/51)

**Merged pull requests:**

- \[tvOS\] Conditionally compile DownView [\#52](https://github.com/johnxnguyen/Down/pull/52) ([iwasrobbed](https://github.com/iwasrobbed))

## [v0.4.1](https://github.com/johnxnguyen/Down/tree/v0.4.1) (2017-10-04)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.4.0...v0.4.1)

**Closed issues:**

- Carthage install fails: no such module 'libcmark' [\#43](https://github.com/johnxnguyen/Down/issues/43)
- Xcode 8.3 warnings [\#26](https://github.com/johnxnguyen/Down/issues/26)

**Merged pull requests:**

- Adds filters to remove Xcode-specific warnings [\#48](https://github.com/johnxnguyen/Down/pull/48) ([128keaton](https://github.com/128keaton))
- Fixes issue \#43 [\#47](https://github.com/johnxnguyen/Down/pull/47) ([128keaton](https://github.com/128keaton))
- Update to Swift 4  [\#46](https://github.com/johnxnguyen/Down/pull/46) ([iwasrobbed](https://github.com/iwasrobbed))

## [v0.4.0](https://github.com/johnxnguyen/Down/tree/v0.4.0) (2017-08-31)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.3.5...v0.4.0)

**Implemented enhancements:**

- Example project [\#37](https://github.com/johnxnguyen/Down/issues/37)
- Markdown tables support [\#36](https://github.com/johnxnguyen/Down/issues/36)

**Closed issues:**

- Unable to build with Xcode 9 [\#41](https://github.com/johnxnguyen/Down/issues/41)
- Can not load local image and link to local .md file [\#40](https://github.com/johnxnguyen/Down/issues/40)
- Fenced code syntax highlighting [\#35](https://github.com/johnxnguyen/Down/issues/35)
- down.toAttributedString\(\) custom text font and image size [\#33](https://github.com/johnxnguyen/Down/issues/33)

**Merged pull requests:**

- Closes “Example” Issue [\#38](https://github.com/johnxnguyen/Down/pull/38) ([128keaton](https://github.com/128keaton))
- Prevent zoom documentation [\#34](https://github.com/johnxnguyen/Down/pull/34) ([Kumuluzz](https://github.com/Kumuluzz))

## [v0.3.5](https://github.com/johnxnguyen/Down/tree/v0.3.5) (2017-05-25)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.3.4...v0.3.5)

**Implemented enhancements:**

- Disable analysis of cmark source code [\#31](https://github.com/johnxnguyen/Down/pull/31) ([tonyarnold](https://github.com/tonyarnold))

## [v0.3.4](https://github.com/johnxnguyen/Down/tree/v0.3.4) (2017-05-13)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.3.3...v0.3.4)

**Merged pull requests:**

- Suggested project fixes/changes [\#28](https://github.com/johnxnguyen/Down/pull/28) ([tonyarnold](https://github.com/tonyarnold))
- Add the ability to initialise a DownView using a custom template bundle [\#27](https://github.com/johnxnguyen/Down/pull/27) ([tonyarnold](https://github.com/tonyarnold))

## [v0.3.3](https://github.com/johnxnguyen/Down/tree/v0.3.3) (2017-03-09)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.3.2...v0.3.3)

**Implemented enhancements:**

- Add OS X support [\#6](https://github.com/johnxnguyen/Down/issues/6)

**Merged pull requests:**

- \#6 macOS Support [\#25](https://github.com/johnxnguyen/Down/pull/25) ([128keaton](https://github.com/128keaton))

## [v0.3.2](https://github.com/johnxnguyen/Down/tree/v0.3.2) (2017-02-26)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.3.1...v0.3.2)

**Implemented enhancements:**

- Create changelog [\#20](https://github.com/johnxnguyen/Down/issues/20)

**Closed issues:**

- A faster substitute to NSHTMLTextDocumentType? [\#23](https://github.com/johnxnguyen/Down/issues/23)
- How to update DownView content and keep the style? [\#19](https://github.com/johnxnguyen/Down/issues/19)

**Merged pull requests:**

- Add tvOS support [\#24](https://github.com/johnxnguyen/Down/pull/24) ([invliD](https://github.com/invliD))
- v0.3.1: Add the ability to update DownView content [\#22](https://github.com/johnxnguyen/Down/pull/22) ([iwasrobbed](https://github.com/iwasrobbed))

## [v0.3.1](https://github.com/johnxnguyen/Down/tree/v0.3.1) (2017-02-09)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.3...v0.3.1)

**Closed issues:**

- How to keep UITextView font style [\#21](https://github.com/johnxnguyen/Down/issues/21)
- Define custom fonts [\#18](https://github.com/johnxnguyen/Down/issues/18)
- Render progress [\#17](https://github.com/johnxnguyen/Down/issues/17)
- Disable zoom WebView [\#16](https://github.com/johnxnguyen/Down/issues/16)
- Text Size of DownView too small [\#15](https://github.com/johnxnguyen/Down/issues/15)
- How to customize the Font? [\#14](https://github.com/johnxnguyen/Down/issues/14)
- Support Images [\#13](https://github.com/johnxnguyen/Down/issues/13)
- How to manually install \(w/o Carthage or CocoaPods\) [\#12](https://github.com/johnxnguyen/Down/issues/12)
- Add support for Carthage [\#8](https://github.com/johnxnguyen/Down/issues/8)

## [v0.3](https://github.com/johnxnguyen/Down/tree/v0.3) (2016-10-12)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.2...v0.3)

**Implemented enhancements:**

- Swift 3.0 support [\#10](https://github.com/johnxnguyen/Down/issues/10)
- Add web view for rendering output [\#3](https://github.com/johnxnguyen/Down/issues/3)

**Closed issues:**

- Can you give an example how to custom the parser? [\#9](https://github.com/johnxnguyen/Down/issues/9)

**Merged pull requests:**

- Swift 3 [\#11](https://github.com/johnxnguyen/Down/pull/11) ([azeff](https://github.com/azeff))
- Adds a few extra tests where possible [\#7](https://github.com/johnxnguyen/Down/pull/7) ([iwasrobbed](https://github.com/iwasrobbed))
- DownView rendering to close \#3 [\#5](https://github.com/johnxnguyen/Down/pull/5) ([iwasrobbed](https://github.com/iwasrobbed))

## [v0.2](https://github.com/johnxnguyen/Down/tree/v0.2) (2016-06-02)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.1.1...v0.2)

**Implemented enhancements:**

- Add attributed string support [\#2](https://github.com/johnxnguyen/Down/issues/2)
- Adds attributed string rendering [\#4](https://github.com/johnxnguyen/Down/pull/4) ([iwasrobbed](https://github.com/iwasrobbed))

## [v0.1.1](https://github.com/johnxnguyen/Down/tree/v0.1.1) (2016-06-01)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/v0.1...v0.1.1)

**Implemented enhancements:**

- Add CocoaPods support & cmark license [\#1](https://github.com/johnxnguyen/Down/pull/1) ([iwasrobbed](https://github.com/iwasrobbed))

## [v0.1](https://github.com/johnxnguyen/Down/tree/v0.1) (2016-06-01)

[Full Changelog](https://github.com/johnxnguyen/Down/compare/69fba2a97e45a07360054a811cac018bec10e17d...v0.1)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
