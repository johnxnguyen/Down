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

    @IBOutlet var progressIndicator: NSProgressIndicator!
    var downView: DownView!

    override func viewDidLoad() {
        super.viewDidLoad()

        progressIndicator.startAnimation(nil)

        // Note: No errors will be thrown here as we're loading an empty Markdown string.
        downView = try! DownView(frame: view.bounds, markdownString: "")
        downView.autoresizingMask = [.width, .height]
        downView.isHidden = true
        view.addSubview(downView)

        DispatchQueue.global(qos: .userInteractive).async {
            self.loadReadMe()
        }
    }

    func loadReadMe() {
        var readMeContents: String

        do {
            let readMeURL = URL(string: "https://raw.githubusercontent.com/iwasrobbed/Down/master/README.md")!
            readMeContents = try String(contentsOf: readMeURL)
        } catch {
            print(error)

            let localReadMeURL = Bundle.main.url(forResource: nil, withExtension: "md")!
            readMeContents = try! String(contentsOf: localReadMeURL)
        }

        DispatchQueue.main.async {
            do {
                try self.downView.update(markdownString: readMeContents, didLoadSuccessfully: {
                    print("Markdown was rendered.")
                    self.progressIndicator.stopAnimation(nil)
                    self.downView.isHidden = false
                })
            } catch {
                NSApp.presentError(error)
            }
        }
    }

}

