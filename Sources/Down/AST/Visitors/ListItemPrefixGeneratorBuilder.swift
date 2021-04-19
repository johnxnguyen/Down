//
//  ListItemPrefixGeneratorBuilder.swift
//  Down
//
//  Created by Loïc DARDANT on 2021-04-19.
//  Copyright © 2021 Down. All rights reserved.
//

import Foundation

/// Builder of `ListItemPrefixGeneratorBuilder` used in `AttributedStringVisitor`.
/// Visitor is creating one ListItemPrefixGenerator per list.
public protocol ListItemPrefixGeneratorBuilder {
    func build(listType: List.ListType, numberOfItems: Int, nestDepth: Int) -> ListItemPrefixGenerator
}

/// Default implementation of `StaticListItemPrefixGeneratorBuilder`, using `StaticListItemPrefixGenerator`.
public class StaticListItemPrefixGeneratorBuilder: ListItemPrefixGeneratorBuilder {

    public init() {}

    public func build(listType: List.ListType, numberOfItems: Int, nestDepth: Int) -> ListItemPrefixGenerator {
        return StaticListItemPrefixGenerator(listType: listType, numberOfItems: numberOfItems, nestDepth: nestDepth)
    }
}
