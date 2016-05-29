//
//  DownHTMLRenderable.swift
//  Down
//
//  Created by Rob Phillips on 5/28/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//

import Foundation
import libcmark

public protocol DownHTMLRenderable: DownRenderable {
    @warn_unused_result
    func toHTML(options: DownOptions) throws -> String
}

public extension DownHTMLRenderable {

    @warn_unused_result
    public func toHTML(options: DownOptions = .Default) throws -> String {
        var outputString: String?
        markdownString.withCString {
            let stringLength = Int(strlen($0))
            let cBuffer = cmark_markdown_to_html($0, stringLength, options.rawValue)
            outputString = String(CString: cBuffer, encoding: NSUTF8StringEncoding)
            free(cBuffer)
        }

        guard let htmlString = outputString else {
            throw DownErrors.ParseError
        }
        return htmlString
    }

}