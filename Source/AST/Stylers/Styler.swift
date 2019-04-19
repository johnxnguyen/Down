//
//  Styler.swift
//  Down
//
//  Created by John Nguyen on 13.04.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

import Foundation

public protocol Styler {
    func style(document str: NSMutableAttributedString)
    func style(blockQuote str: NSMutableAttributedString)
    func style(list str: NSMutableAttributedString)
    func style(item str: NSMutableAttributedString)
    func style(codeBlock str: NSMutableAttributedString)
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
    
    var listPrefixAttributes: [NSAttributedStringKey: Any] { get }
}
