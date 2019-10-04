//
//  NSAttributedString+HTML.swift
//  Down
//
//  Created by Rob Phillips on 6/1/16.
//  Copyright © 2016-2019 Down. All rights reserved.
//

#if os(macOS)
    import AppKit
#else
    import UIKit
#endif


extension NSAttributedString {

    /// Instantiates an attributed string with the given HTML string
    ///
    /// - Parameter htmlString: An HTML string
    /// - Throws: `HTMLDataConversionError` or an instantiation error
    convenience init(htmlString: String) throws {
        guard let data = htmlString.data(using: String.Encoding.utf8) else {
            throw DownErrors.htmlDataConversionError
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: NSNumber(value: String.Encoding.utf8.rawValue)
        ]
        try self.init(data: data, options: options, documentAttributes: nil)
    }

}
