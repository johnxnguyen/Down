//
//  DownAttributedStringRenderable.swift
//  Down
//
//  Created by Rob Phillips on 6/1/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//

import Foundation
import libcmark

public protocol DownAttributedStringRenderable: DownHTMLRenderable {
    /**
     Generates an `NSAttributedString` from the `markdownString` property

     - parameter options: `DownOptions` to modify parsing or rendering

     - throws: `DownErrors` depending on the scenario

     - returns: An `NSAttributedString`
     */
    
    func toAttributedString(_ options: DownOptions) throws -> NSAttributedString
}

public extension DownAttributedStringRenderable {
    /**
     Generates an `NSAttributedString` from the `markdownString` property

     - parameter options: `DownOptions` to modify parsing or rendering, defaulting to `.Default`

     - throws: `DownErrors` depending on the scenario

     - returns: An `NSAttributedString`
     */
    
    public func toAttributedString(_ options: DownOptions = .Default) throws -> NSAttributedString {
        let html = try self.toHTML(options)
        return try NSAttributedString(htmlString: html)
    }
}
