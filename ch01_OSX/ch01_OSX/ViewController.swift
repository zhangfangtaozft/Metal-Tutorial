//
//  ViewController.swift
//  ch01_OSX
//
//  Created by frank.Zhang on 05/06/2018.
//  Copyright © 2018 Frank.Zhang. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var label: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let devices = MTLCopyAllDevices()
        guard let _ = devices.first  else {
            fatalError("Your GPU doesn't support Metal!")
        }
        label.stringValue = "Your system has the following GPU(s):\n"
        for device in devices {
            label.stringValue += "\(device.name)\n"
        }
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}

