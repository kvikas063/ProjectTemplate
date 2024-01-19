//
//  ViewController.swift
//  ProjectTemplate
//
//  Created by Vikas Kumar on 18/01/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if AHReachability.shared.isNetworkAvailable {
            debugPrint("Network is available!")
        } else {
            debugPrint("Network is not available!")
        }
    }
}
