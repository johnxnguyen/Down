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
     Thrown when there was an issue converting the Markdown into an abstract syntax tree
     */
    case MarkdownToASTError

    /**
     Thrown when the abstract syntax tree could not be rendered into another format
    */
    case ASTRenderingError

    /**
     Thrown when an HTML string cannot be converted into an `NSData` representation
    */
    case HTMLDataConversionError
}