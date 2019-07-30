//
//  AttributeCollection.swift
//  Down
//
//  Created by John Nguyen on 27.07.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

import Foundation

public protocol AttributeCollection {

    associatedtype Attribute

    var heading1: Attribute { get }
    var heading2: Attribute { get }
    var heading3: Attribute { get }
    var body: Attribute { get }
    var quote: Attribute { get }
    var code: Attribute { get }
}

public extension AttributeCollection {

    func attributeFor(headingLevel: Int) -> Attribute? {
        switch headingLevel {
        case 1: return heading1
        case 2: return heading2
        case 3...6: return heading3
        default: return nil
        }
    }
}
