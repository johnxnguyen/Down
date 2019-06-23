//
//  ListItemPrefixGenerator.swift
//  Down
//
//  Created by John Nguyen on 23.06.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

import Foundation

class ListItemPrefixGenerator {

    private var prefixes: IndexingIterator<[String]>

    init(list: List) {
        switch list.listType {
        case .bullet:
            prefixes = [String](repeating: "•", count: list.numberOfItems)
                .makeIterator()

        case .ordered(let start):
            prefixes = (start...(start + list.numberOfItems))
                .map { "\($0)." }
                .makeIterator()
        }
    }

    func next() -> String? {
        prefixes.next()
    }
}
