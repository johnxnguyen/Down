//
//  DefaultStyler.swift
//  Down
//
//  Created by John Nguyen on 22.06.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

import Foundation

open class DefaultStyler: Styler {

    public var listPrefixAttributes: [NSAttributedString.Key : Any] = [:]
}

// MARK: - Styling

extension DefaultStyler {
    
    open func style(document str: NSMutableAttributedString) {

    }

    open func style(blockQuote str: NSMutableAttributedString) {

    }

    open func style(list str: NSMutableAttributedString) {

    }

    open func style(item str: NSMutableAttributedString) {

    }

    open func style(codeBlock str: NSMutableAttributedString, fenceInfo: String?) {

    }

    open func style(htmlBlock str: NSMutableAttributedString) {

    }

    open func style(customBlock str: NSMutableAttributedString) {

    }

    open func style(paragraph str: NSMutableAttributedString) {

    }

    open func style(heading str: NSMutableAttributedString, level: Int) {

    }

    open func style(thematicBreak str: NSMutableAttributedString) {

    }

    open func style(text str: NSMutableAttributedString) {

    }

    open func style(softBreak str: NSMutableAttributedString) {

    }

    open func style(lineBreak str: NSMutableAttributedString) {

    }

    open func style(code str: NSMutableAttributedString) {

    }

    open func style(htmlInline str: NSMutableAttributedString) {

    }

    open func style(customInline str: NSMutableAttributedString) {

    }

    open func style(emphasis str: NSMutableAttributedString) {

    }

    open func style(strong str: NSMutableAttributedString) {

    }

    open func style(link str: NSMutableAttributedString, title: String?, url: String?) {

    }

    open func style(image str: NSMutableAttributedString, title: String?, url: String?) {

    }
}
