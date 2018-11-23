//
//  ViewController.swift
//  macOS Demo
//
//  Created by Chris Zielinski on 10/27/18.
//  Copyright © 2018 down. All rights reserved.
//

import Cocoa
import Down

class ViewController: NSViewController {

    var downView: DownView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let readMeURL = Bundle.main.url(forResource: nil, withExtension: "md")!
        let readMeContents = try! String(contentsOf: readMeURL)

        do {
            downView = try DownView(frame: view.bounds, markdownString: readMeContents, didLoadSuccessfully: {
                print("Markdown was rendered.")
            })
        } catch {
            NSApp.presentError(error)
        }

        downView.autoresizingMask = [.width, .height]
        view.addSubview(downView, positioned: .below, relativeTo: nil)
    }
}

