//
//  DownDebugTextView.swift
//  Down
//
//  Created by John Nguyen on 06.08.19.
//  Copyright © 2019 Glazed Donut, LLC. All rights reserved.
//

#if canImport(UIKit)

import Foundation
import  UIKit

public class DownDebugTextView: DownTextView {

    public init(frame: CGRect) {
        super.init(frame: frame, layoutManager: DownDebugLayoutManager())
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#endif
