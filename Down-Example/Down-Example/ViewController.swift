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

    var downView: DownView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downView = try? DownView(frame: self.view.bounds, markdownString: "**Oh Hai**") {
            // Optional callback for loading finished
            self.view.addSubview(self.downView!)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

