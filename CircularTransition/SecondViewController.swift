//
//  SecondViewController.swift
//  CircularTransition
//
//  Created by Julio Collado on 1/13/20.
//  Copyright © 2020 Julio Collado. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var dismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissButton.layer.cornerRadius = dismissButton.frame.size.width / 2
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
