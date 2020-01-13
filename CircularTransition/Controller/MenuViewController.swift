//
//  MenuViewController.swift
//  CircularTransition
//
//  Created by Julio Collado on 1/13/20.
//  Copyright © 2020 Julio Collado. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let closeButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        closeButton.setTitle("X", for: .normal)
        closeButton.setTitleColor(.systemOrange, for: .normal)
        closeButton.backgroundColor = UIColor.white
        closeButton.layer.cornerRadius = closeButton.frame.size.width / 2
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeButton)
    }
    
    @objc func didTapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
