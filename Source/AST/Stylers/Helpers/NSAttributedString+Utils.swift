//
//  NSAttributedString+Utils.swift
//  Down
//
//  Created by John Nguyen on 25.06.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

import Foundation

extension NSAttributedString {

    func prefix(with length: Int) -> NSAttributedString {
        guard length <= self.length else { return self }
        return attributedSubstring(from: NSMakeRange(0, length))
    }
}
