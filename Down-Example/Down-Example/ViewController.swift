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
            let alertController = UIAlertController(title: "DownView Render Error",
                                                    message: error.localizedDescription,
                                                    preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
        }

        view.addSubview(downView)

        createStatusBarBackgrounds()
    }

    func createStatusBarBackgrounds() {
        let blurEffect = UIBlurEffect(style: .prominent)
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

