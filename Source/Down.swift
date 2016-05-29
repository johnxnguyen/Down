//
//  Down.swift
//  Down
//
//  Created by Rob Phillips on 5/28/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//

import Foundation

public class Down: DownHTMLRenderable {

    public var markdownString: String

    @warn_unused_result
    public init(markdownString: String) {
        self.markdownString = markdownString
    }

}