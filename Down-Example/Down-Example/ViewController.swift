//
//  ViewController.swift
//  Down-Example
//
//  Created by Keaton Burleson on 7/1/17.
//  Copyright © 2017 down. All rights reserved.
//

import UIKit
import Down

class ViewController: UIViewController {

    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var visualEffectContentView: UIView!
    var downView: DownView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Note: No errors will be thrown here as we're loading an empty Markdown string.
        downView = try! DownView(frame: view.bounds, markdownString: "")
        downView.isHidden = true
        visualEffectContentView.addSubview(downView)

        createStatusBarBackgrounds()

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
                    self.activityIndicatorView.stopAnimating()
                    self.downView.isHidden = false
                })
            } catch {
                let alertController = UIAlertController(title: "DownView Render Error",
                                                        message: error.localizedDescription,
                                                        preferredStyle: UIAlertControllerStyle.alert)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

    func createStatusBarBackgrounds() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurEffectView, aboveSubview: downView)

        NSLayoutConstraint.activate([
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurEffectView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor)
            ])
    }

}

