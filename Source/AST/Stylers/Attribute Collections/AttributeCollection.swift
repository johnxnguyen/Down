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
