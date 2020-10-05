//
//  ChildSequence.swift
//  Down
//
//  Created by Sven Weidauer on 05.10.2020
//

import libcmark

/// Sequence of child nodes
public struct ChildSequence: Sequence {
    let node: CMarkNode

    public struct Iterator: IteratorProtocol {
        var node: CMarkNode?

        public mutating func next() -> Node? {
            guard let node = node else { return nil }
            defer { self.node = cmark_node_next(node) }

            guard let result = node.wrap() else {
                assertionFailure("Couldn't wrap node of type: \(node.type)")
                return nil
            }

            return result
        }
    }

    public func makeIterator() -> Iterator {
        return Iterator(node: cmark_node_first_child(node))
    }
}

