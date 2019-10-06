//
//  Styler.swift
//  Down
//
//  Created by John Nguyen on 13.04.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import Foundation

/// A styler is an object that manipulates the appearance of attributed strings generated
/// for each particular markdown node. The attributed string passed into each method is
/// mutable, so new attributes can be added and/or existing attributes modified or removed.
///
/// When applying paragraph styles to a string, take care not to cause any conflicts with
/// existing paragraph styles, as this can lead to visual bugs that are difficult to
/// understand.
///
/// A styler is used in conjunction with an instance of `AttributedStringVisitor` in order
/// to generate an NSAttributedString from an abstract syntax tree.
public protocol Styler {

    /// Styles the content of the document in the given string.
    ///
    /// - Parameter str: the document content.
    func style(document str: NSMutableAttributedString)


    /// Styles the content of the block quote contained in the given string.
    ///
    /// - Parameter str: the quote content.
    /// - Parameter nestDepth: the zero indexed nesting depth of the block quote node.
    func style(blockQuote str: NSMutableAttributedString, nestDepth: Int)


    /// Styles the content of the list contained in the given string.
    ///
    /// - Parameter str: the list content.
    /// - Parameter nestDepth: the zero indexed nesting depth of the list node.
    func style(list str: NSMutableAttributedString, nestDepth: Int)


    /// Styles the number or bullet list item prefix.
    ///
    /// - Parameter str: the list item prefix.
    func style(listItemPrefix str: NSMutableAttributedString)


    /// Styles the content of the list item contained in the given string, including the
    /// number or bullet prefix.
    ///
    /// - Parameter str: the item content.
    /// - Parameter prefixLength: the character length of the number or bullet prefix.
    func style(item str: NSMutableAttributedString, prefixLength: Int)


    /// Styles the content of the code block in the given string.
    ///
    /// An example use case for `fenceInfo` is to specify a programming language name,
    /// which could be used to support syntax highlighting.
    ///
    /// - Parameter str: the code content.
    /// - Parameter fenceInfo: the string that trails the initial ``` ticks.
    func style(codeBlock str: NSMutableAttributedString, fenceInfo: String?)


    /// Styles the content of the html block contained in the given string.
    ///
    /// - Parameter str: the html content.
    func style(htmlBlock str: NSMutableAttributedString)


    /// Styles the content of the custom block contained in the given string.
    ///
    /// - Parameter str: the content.
    func style(customBlock str: NSMutableAttributedString)


    /// Styles the content of the paragraph in the given string.
    ///
    /// - Parameter str: the paragraph content.
    func style(paragraph str: NSMutableAttributedString)


    /// Styles the content of the heading in the given string.
    ///
    /// - Parameter str: the heading content.
    /// - Parameter level: the heading level [1, 6]
    func style(heading str: NSMutableAttributedString, level: Int)


    /// Styles the content of the thematic break in the given string.
    ///
    /// - Parameter str: the thematic break.
    func style(thematicBreak str: NSMutableAttributedString)


    /// Styles the content of the inline text node in the given string.
    ///
    /// The text nodes are always the leaves of the AST, thus they
    /// contain the base style upon which other nodes can work with.
    ///
    /// - Parameter str: the text content.
    func style(text str: NSMutableAttributedString)


    /// Styles the content of the soft break in the given string.
    ///
    /// - Parameter str: the soft break.
    func style(softBreak str: NSMutableAttributedString)


    /// Styles the content of the line break in the given string.
    ///
    /// - Parameter str: the line break.
    func style(lineBreak str: NSMutableAttributedString)


    /// Styles the content of the inline code in the given string.
    ///
    /// - Parameter str: the code content.
    func style(code str: NSMutableAttributedString)


    /// Styles the content of the inline html tags in the given string.
    ///
    /// Note, the content does not include text between matching tags.
    ///
    /// - Parameter str: the html content.
    func style(htmlInline str: NSMutableAttributedString)


    /// Styles the content of the inline custom node in the given string.
    ///
    /// - Parameter str: the custom content.
    func style(customInline str: NSMutableAttributedString)


    /// Styles the content of the inline emphasis node in the given string.
    ///
    /// - Parameter str: the ephasized content.
    func style(emphasis str: NSMutableAttributedString)


    /// Styles the content of the inline strong node in the given string.
    ///
    /// - Parameter str: the strong content.
    func style(strong str: NSMutableAttributedString)


    /// Styles the content of the inline link node in the given string.
    ///
    /// - Parameter str: the link content.
    /// - Parameter title: the link title.
    /// - Parameter url: the linked url.
    func style(link str: NSMutableAttributedString, title: String?, url: String?)

    /// Styles the content of the inline image node in the given string.
    ///
    /// - Parameter str: the link content.
    /// - Parameter title: the link title.
    /// - Parameter url: the linked url.
    func style(image str: NSMutableAttributedString, title: String?, url: String?)
}
