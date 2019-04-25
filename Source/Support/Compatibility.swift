//
//  Compatibility.swift
//  Down
//
//  Created by Ilya Laryionau on 25/04/2019.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

import Foundation

#if swift(>=4.2)
#else
extension NSAttributedString {
    public typealias Key = NSAttributedStringKey
}
#endif
