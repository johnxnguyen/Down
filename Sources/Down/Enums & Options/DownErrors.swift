//
//  DownErrors.swift
//  Down
//
//  Created by Rob Phillips on 5/28/16.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import Foundation

public enum DownErrors: Error {

    /// Thrown when there was an issue converting the Markdown into an abstract syntax tree.

    case markdownToASTError

    /// Thrown when the abstract syntax tree could not be rendered into another format.

    case astRenderingError

    /// Thrown when an HTML string cannot be converted into an `NSData` representation.

    case htmlDataConversionError

    #if os(macOS)

    /// Thrown when a custom template bundle has a non-standard bundle format.
    ///
    /// Specifically, the file URL of the bundle’s subdirectory containing resource files could
    /// not be found (i.e. the bundle's `resourceURL` property is nil).

    case nonStandardBundleFormatError

    #endif

}
