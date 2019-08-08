//
//  NSAttributedString+Key.swift
//  Down
//
//  Created by John Nguyen on 24.06.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

import Foundation

// TODO: Check this is safe to use for older versions.
extension NSAttributedString.Key {
    static let listMarker = NSAttributedString.Key("listMarker")
    static let itemPrefixMarker = NSAttributedString.Key("itemPrefixMarker")
}
