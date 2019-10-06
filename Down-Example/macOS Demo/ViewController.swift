//
//  ViewController.swift
//  macOS Demo
//
//  Created by Chris Zielinski on 10/27/18.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import Cocoa
import Down

final class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        renderDownInWebView()
    }
    
}

private extension ViewController {
    
    func renderDownInWebView() {
        let readMeURL = Bundle.main.url(forResource: nil, withExtension: "md")!
        let readMeContents = try! String(contentsOf: readMeURL)
        
        do {
            let downView = try DownView(frame: view.bounds, markdownString: readMeContents, didLoadSuccessfully: {
                print("Markdown was rendered.")
            })
            downView.autoresizingMask = [.width, .height]
            view.addSubview(downView, positioned: .below, relativeTo: nil)
        } catch {
            NSApp.presentError(error)
        }
    }
}

