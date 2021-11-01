//
//  ViewController.swift
//  D2D
//
//  Created by Ahmed Eldably on 25.09.21.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBSegueAction func swiftUIAction(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: MapView())
    }
    
}

