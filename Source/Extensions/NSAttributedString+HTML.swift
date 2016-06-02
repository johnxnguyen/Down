//
//  NSAttributedString+HTML.swift
//  Down
//
//  Created by Rob Phillips on 6/1/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//

import UIKit

extension NSAttributedString {

    /**
     Instantiates an attributed string with the given HTML string

     - parameter htmlString: An HTML string

     - throws: `HTMLDataConversionError` or an instantiation error

     - returns: An attributed string
     */
    convenience init(htmlString: String) throws {
        guard let data = htmlString.dataUsingEncoding(NSUTF8StringEncoding) else {
            throw DownErrors.HTMLDataConversionError
        }

        let options = [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                       NSCharacterEncodingDocumentAttribute: NSNumber(unsignedInteger:NSUTF8StringEncoding)]
        try self.init(data: data, options: options, documentAttributes: nil)
    }

}