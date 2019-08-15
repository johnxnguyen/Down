//
//  FontCollection.swift
//  Down
//
//  Created by John Nguyen on 22.06.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import UIKit

public struct FontCollection {

    public var heading1 = UIFont.boldSystemFont(ofSize: 28)
    public var heading2 = UIFont.boldSystemFont(ofSize: 24)
    public var heading3 = UIFont.boldSystemFont(ofSize: 20)
    public var body = UIFont.systemFont(ofSize: 17)

    public var code: UIFont = {
        if #available(iOS 12, *) {
            return .monospacedSystemFont(ofSize: 17, weight: .regular)
        }
        else {
            return UIFont(name: "menlo", size: 17) ?? .systemFont(ofSize: 17)
        }

    }()

    public var listItemPrefix: UIFont = {
        UIFont.monospacedDigitSystemFont(ofSize: 17, weight: .regular)
    }()
}

#endif
