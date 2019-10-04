//
//  ListItemPrefixGenerator.swift
//  Down
//
//  Created by John Nguyen on 23.06.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import Foundation

class ListItemPrefixGenerator {

    private var prefixes: IndexingIterator<[String]>

    convenience init(list: List) {
        self.init(listType: list.listType, numberOfItems: list.numberOfItems)
    }

    init(listType: List.ListType, numberOfItems: Int) {
        switch listType {
        case .bullet:
            prefixes = [String](repeating: "•", count: numberOfItems)
                .makeIterator()

        case .ordered(let start):
            prefixes = (start..<(start + numberOfItems))
                .map { "\($0)." }
                .makeIterator()
        }
    }

    func next() -> String? {
        prefixes.next()
    }
}
