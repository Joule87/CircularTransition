//
//  ViewController.swift
//  CircularTransition
//
//  Created by Julio Collado on 1/13/20.
//  Copyright © 2020 Julio Collado. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    
    let transition = CircularTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        menuButton.layer.cornerRadius = menuButton.frame.size.width / 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sendVC = segue.destination as? SecondViewController {
            sendVC.transitioningDelegate = self
            sendVC.modalPresentationStyle = .custom
        }
        
    }
    
}

extension FirstViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startPoint = menuButton.center
        transition.circleColor = menuButton.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startPoint = menuButton.center
        transition.circleColor = menuButton.backgroundColor!
        
        return transition
    }
}
