//
//  DownErrors.swift
//  Down
//
//  Created by Rob Phillips on 5/28/16.
//  Copyright © 2016 Glazed Donut, LLC. All rights reserved.
//

import Foundation

public enum DownErrors: ErrorType {
    /**
     Indicates that cmark could not properly parse the Markdown for some reason :(
    */
    case ParseError
}