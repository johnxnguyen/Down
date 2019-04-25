//
//  Styler.swift
//  Down
//
//  Created by John Nguyen on 13.04.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

import Foundation

/// A styler is an object that manipulates the appearance of attributed strings generated
/// for each particular markdown node. The attributed string passed into each method is
/// mutable, so attributes (and even text) can be added, set, and removed.
///
/// A styler is used in conjunction with an instance of `AttributedStringVisitor` in order
/// to generate an NSAttributedString from an abstract syntax tree.
public protocol Styler {
    func style(document str: NSMutableAttributedString)
    func style(blockQuote str: NSMutableAttributedString)
    func style(list str: NSMutableAttributedString)
    func style(item str: NSMutableAttributedString)
    func style(codeBlock str: NSMutableAttributedString, fenceInfo: String?)
    func style(htmlBlock str: NSMutableAttributedString)
    func style(customBlock str: NSMutableAttributedString)
    func style(paragraph str: NSMutableAttributedString)
    func style(heading str: NSMutableAttributedString, level: Int)
    func style(thematicBreak str: NSMutableAttributedString)
    func style(text str: NSMutableAttributedString)
    func style(softBreak str: NSMutableAttributedString)
    func style(lineBreak str: NSMutableAttributedString)
    func style(code str: NSMutableAttributedString)
    func style(htmlInline str: NSMutableAttributedString)
    func style(customInline str: NSMutableAttributedString)
    func style(emphasis str: NSMutableAttributedString)
    func style(strong str: NSMutableAttributedString)
    func style(link str: NSMutableAttributedString, title: String?, url: String?)
    func style(image str: NSMutableAttributedString, title: String?, url: String?)
    
    var listPrefixAttributes: [NSAttributedString.Key: Any] { get }
}
