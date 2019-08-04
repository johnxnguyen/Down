//
//  DownTextView.swift
//  Down
//
//  Created by John Nguyen on 03.08.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import  UIKit

open class DownTextView: UITextView {

    public init(frame: CGRect) {
        let textStorage = NSTextStorage()
        let layoutManager = DownLayoutManager()
        let textContainer = NSTextContainer()

        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)

        super.init(frame: frame, textContainer: textContainer)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#endif