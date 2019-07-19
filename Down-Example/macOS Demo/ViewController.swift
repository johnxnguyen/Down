//
//  ViewController.swift
//  macOS Demo
//
//  Created by Chris Zielinski on 10/27/18.
//  Copyright © 2018 down. All rights reserved.
//

import Cocoa
import Down

final class ViewController: NSViewController {

    @IBOutlet var textView: NSTextView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        renderDownInWebView()
        renderDownInTextView()
        
    }
    
}

private extension ViewController {
    
    func renderDownInWebView() {
        let readMeURL = Bundle.main.url(forResource: nil, withExtension: "md")!
        let readMeContents = try! String(contentsOf: readMeURL)
        
        do {
            let downView = try DownView(frame: view.bounds, markdownString: readMeContents, didLoadSuccessfully: {
                print("Markdown was rendered.")
            })
            downView.autoresizingMask = [.width, .height]
            view.addSubview(downView, positioned: .below, relativeTo: nil)
        } catch {
            NSApp.presentError(error)
        }
    }
    
    func renderDownInTextView() {
        let readMeURL = Bundle.main.url(forResource: nil, withExtension: "md")!
        let readMeContents = try! String(contentsOf: readMeURL)
        
        do {
            let down = Down(markdownString: readMeContents)
            let attri = try down.toAttributedString(styler: MTStyler(values: StyleValues(), listPrefixAttributes: [:]))
            textView.textStorage?.append(attri)
        } catch {
            NSApp.presentError(error)
        }
    }
}

private class EmptyStyler: Styler {
    var listPrefixAttributes: [NSAttributedString.Key : Any] = [:]
    func style(document str: NSMutableAttributedString) {}
    func style(blockQuote str: NSMutableAttributedString) {}
    func style(list str: NSMutableAttributedString) {}
    func style(item str: NSMutableAttributedString) {}
    func style(codeBlock str: NSMutableAttributedString, fenceInfo: String?) {}
    func style(htmlBlock str: NSMutableAttributedString) {}
    func style(customBlock str: NSMutableAttributedString) {}
    func style(paragraph str: NSMutableAttributedString) {}
    func style(heading str: NSMutableAttributedString, level: Int) {}
    func style(thematicBreak str: NSMutableAttributedString) {}
    func style(text str: NSMutableAttributedString) {}
    func style(softBreak str: NSMutableAttributedString) {}
    func style(lineBreak str: NSMutableAttributedString) {}
    func style(code str: NSMutableAttributedString) {}
    func style(htmlInline str: NSMutableAttributedString) {}
    func style(customInline str: NSMutableAttributedString) {}
    func style(emphasis str: NSMutableAttributedString) {}
    func style(strong str: NSMutableAttributedString) {}
    func style(link str: NSMutableAttributedString, title: String?, url: String?) {}
    func style(image str: NSMutableAttributedString, title: String?, url: String?) {}
}

struct StyleValues {
    let lineSpacing: CGFloat = 0
    
    let bodyFont = "Helvetica Neue"
    let bodySize: CGFloat = 12
    let bodySpacing: CGFloat = 18
    
    let h1Spacing: CGFloat = 18
    let h1Font = "Helvetica Neue"
    let h1Size: CGFloat = 24
    
    let h2Spacing: CGFloat = 18
    let h2Font = "Helvetica Neue"
    let h2Size: CGFloat = 24
    
    let h3Spacing: CGFloat = 18
    let h3Font = "Helvetica Neue"
    let h3Size: CGFloat = 18
    
    let h4Spacing: CGFloat = 18
    let h4Font = "Helvetica Neue"
    let h4Size: CGFloat = 24
    
    let h5Spacing: CGFloat = 18
    let h5Font = "Helvetica Neue"
    let h5Size: CGFloat = 14
    
    let h6Spacing: CGFloat = 18
    let h6Font = "Helvetica Neue"
    let h6Size: CGFloat = 24
    
    
    let blockquoteIndent: CGFloat = 10
    let blockquoteSpacing: CGFloat = 18
    
    let codeFontName = "Menlo"
    let codeFontSize: CGFloat = 12
    let codeBackgroundColor = NSColor(calibratedWhite: 0.9, alpha: 1)
    let codeParagraphSpacing: CGFloat = 18
    let codeLineSpacing: CGFloat = 0
    
    let htmlSpacing: CGFloat = 18
    
    let thematicBreakColor = NSColor(calibratedWhite: 0.7, alpha: 1)
}


extension NSMutableAttributedString {
    func addAttributes(_ attributes: [NSAttributedString.Key: Any]) {
        addAttributes(attributes, range: NSRange(location: 0, length: length))
    }
}


struct MTStyler: Styler {
    let values: StyleValues
    
    var listPrefixAttributes: [NSAttributedString.Key : Any] = [:]
    
    func defaultParagraphStyle() -> NSMutableParagraphStyle {
        let parStyle = NSMutableParagraphStyle()
        parStyle.paragraphSpacing = values.bodySpacing
        parStyle.lineSpacing = values.lineSpacing
        return parStyle
    }
    
    func style(document str: NSMutableAttributedString) {
        //    str.addAttributes([.font: NSFont(name: values.bodyFont, size: values.bodySize)!])
    }
    
    func style(blockQuote str: NSMutableAttributedString) {
        let parStyle = defaultParagraphStyle()
        parStyle.paragraphSpacing = values.blockquoteSpacing
        parStyle.headIndent = values.blockquoteIndent
        parStyle.firstLineHeadIndent = values.blockquoteIndent
        str.addAttributes([.paragraphStyle: parStyle])
    }
    
    func style(list str: NSMutableAttributedString) {
        str.addAttributes([.paragraphStyle: defaultParagraphStyle()])
        print(str.debugDescription)
    }
    
    func style(item str: NSMutableAttributedString) {
        
    }
    
    func style(codeBlock str: NSMutableAttributedString, fenceInfo: String?) {
        guard let font = NSFont(name: values.codeFontName, size: values.codeFontSize) else {
            fatalError("Font not found")
        }
        let parStyle = defaultParagraphStyle()
        parStyle.paragraphSpacing = values.codeParagraphSpacing
        parStyle.lineSpacing = values.codeLineSpacing
        str.addAttributes(
            [
                .font: font,
                .backgroundColor: values.codeBackgroundColor,
                .paragraphStyle: parStyle,
            ],
            range: NSRange(location: 0, length: str.length))
    }
    
    func style(htmlBlock str: NSMutableAttributedString) {
        str.addAttributes([.paragraphStyle: defaultParagraphStyle()])
    }
    
    func style(customBlock str: NSMutableAttributedString) {
        str.addAttributes([.paragraphStyle: defaultParagraphStyle()])
    }
    
    func style(paragraph str: NSMutableAttributedString) {
        str.addAttributes([.paragraphStyle: defaultParagraphStyle()])
    }
    
    func style(heading str: NSMutableAttributedString, level: Int) {
        let spacingOptions: [Int: CGFloat] = [
            1: values.h1Spacing,
            2: values.h2Spacing,
            3: values.h3Spacing,
            4: values.h4Spacing,
            5: values.h5Spacing,
            6: values.h6Spacing,
        ]
        let fontOptions: [Int: String] = [
            1: values.h1Font,
            2: values.h2Font,
            3: values.h3Font,
            4: values.h4Font,
            5: values.h5Font,
            6: values.h6Font,
        ]
        let sizeOptions: [Int: CGFloat] = [
            1: values.h1Size,
            2: values.h2Size,
            3: values.h3Size,
            4: values.h4Size,
            5: values.h5Size,
            6: values.h6Size,
        ]
        let fm = NSFontManager.shared
        let font = fm.font(
            withFamily: fontOptions[level]!,
            traits: .boldFontMask,
            weight: 9, // ignored due to mask
            size: sizeOptions[level]!)!
        let parStyle = defaultParagraphStyle()
        parStyle.paragraphSpacing = spacingOptions[level]!
        str.insert(NSAttributedString.init(string: "# "), at: 0)
        str.addAttributes([
            .paragraphStyle: parStyle,
            .font: font,
            ])
//        str.insert(NSAttributedString.init(string: "# ", attributes: [
//            .paragraphStyle: parStyle,
//            .font: font,
//            ]), at: 0)
    }
    
    func style(thematicBreak str: NSMutableAttributedString) {
        let parStyle = defaultParagraphStyle()
        parStyle.alignment = .left
        
        str.replaceCharacters(
            in: NSRange(location: 0, length: str.length),
            with: NSAttributedString(
                string: "\u{00A0}\u{0009}\u{00A0}\n",
                attributes: [
                    .paragraphStyle: parStyle,
                    .strikethroughColor: values.thematicBreakColor,
                    .strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue)
                ]))
    }
    
    func style(text str: NSMutableAttributedString) {
        
    }
    
    func style(softBreak str: NSMutableAttributedString) {
        
    }
    
    func style(lineBreak str: NSMutableAttributedString) {
        
    }
    
    func style(code str: NSMutableAttributedString) {
        guard let font = NSFont(name: values.codeFontName, size: values.codeFontSize) else {
            fatalError("Font not found")
        }
        str.addAttributes(
            [
                .font: font,
                .backgroundColor: values.codeBackgroundColor,
            ],
            range: NSRange(location: 0, length: str.length))
    }
    
    func style(htmlInline str: NSMutableAttributedString) {
        
    }
    
    func style(customInline str: NSMutableAttributedString) {
        
    }
    
    func style(emphasis str: NSMutableAttributedString) {
        let attrs = str.fontAttributes(in: NSRange(location: 0, length: 1))
        let font = (attrs.values.first as? NSFont) ?? NSFont(name: values.bodyFont, size: values.bodySize)!
        let fm = NSFontManager.shared
        str.addAttributes([.font: fm.convert(font, toHaveTrait: .italicFontMask)])
        
    }
    
    func style(strong str: NSMutableAttributedString) {
        let attrs = str.fontAttributes(in: NSRange(location: 0, length: 1))
        let font = (attrs.values.first as? NSFont) ?? NSFont(name: values.bodyFont, size: values.bodySize)!
        let fm = NSFontManager.shared
        str.addAttributes([.font: fm.convert(font, toHaveTrait: .boldFontMask)])
        
    }
    
    func style(link str: NSMutableAttributedString, title: String?, url: String?) {
        if let url = url {
            str.addAttributes([.link: url])
        }
    }
    
    func style(image str: NSMutableAttributedString, title: String?, url: String?) {
        if let url = url {
            str.addAttributes([.link: url])
        }
    }
}
