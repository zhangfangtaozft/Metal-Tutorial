//
//  ViewController.swift
//  Ch01-iOS
//
//  Created by frank.Zhang on 05/06/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard  let device = MTLCreateSystemDefaultDevice() else {
            fatalError("Your GPU does not support Metal!")
        }
        label.text = "Your system has the following GPU(s):\n" + "\(device.name)\n"
    }
}

