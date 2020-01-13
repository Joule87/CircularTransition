//
//  CircularTransition.swift
//  CircularTransition
//
//  Created by Julio Collado on 1/13/20.
//  Copyright © 2020 Julio Collado. All rights reserved.
//

import UIKit

class CircularTransition: NSObject {
    
    var circle = UIView()
    
    var startPoint = CGPoint.zero {
        didSet {
            circle.center = startPoint
        }
    }
    
    var circleColor = UIColor.white
    var duration = 0.3
    
    enum TransitionMode: Int {
        case present, dismiss, pop
    }
    
    var transitionMode = TransitionMode.present
    
}

extension CircularTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let transitionModeKey: UITransitionContextViewKey?
        
        switch transitionMode {
        case .present:
            presentView(transitionContext, containerView)
            return
        case .dismiss:
            transitionModeKey = UITransitionContextViewKey.from
            break
        case .pop:
            transitionModeKey = UITransitionContextViewKey.to
            break
        }
        
        if let key = transitionModeKey, let returngView = transitionContext.view(forKey: key) {
            let viewCenter = returngView.center
            let viewSize = returngView.frame.size
            circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startPoint)
            
            circle.layer.cornerRadius = circle.frame.size.height / 2
            circle.center = startPoint
            
            animate(returngView, containerView, viewCenter, transitionContext)
        }
    }
    
    private func presentView(_ transitionContext: UIViewControllerContextTransitioning, _ containerView: UIView) {
        if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
            let viewSize = presentedView.frame.size
            let viewCenter = presentedView.center
            
            circle = UIView()
            
            circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startPoint)
            
            circle.layer.cornerRadius = circle.frame.size.height / 2
            
            circle.center = startPoint
            circle.backgroundColor = circleColor
            circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            containerView.addSubview(circle)
            
            presentedView.center = startPoint
            presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            presentedView.alpha = 0
            containerView.addSubview(presentedView)
            
            UIView.animate(withDuration: duration, animations: {
                self.circle.transform = .identity
                presentedView.transform = .identity
                presentedView.alpha = 1
                presentedView.center = viewCenter
            }) { (success: Bool) in
                transitionContext.completeTransition(success)
            }
        }
    }
    
    private func frameForCircle(withViewCenter viewCenter: CGPoint, size viewSize: CGSize, startPoint: CGPoint) -> CGRect {
        
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)
        
        let offsetVector = sqrt(xLength * xLength + yLength * yLength) * 2
        
        let size = CGSize(width: offsetVector, height: offsetVector)
        
        return CGRect(origin: .zero, size: size)
        
    }
    
    private func animate(_ returngView: UIView, _ containerView: UIView, _ viewCenter: CGPoint, _ transitionContext: UIViewControllerContextTransitioning) {
        UIView.animate(withDuration: duration, animations: {
            self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            returngView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            returngView.center = self.startPoint
            returngView.alpha = 0
            
            if self.transitionMode == .pop {
                containerView.insertSubview(returngView, belowSubview: returngView)
                containerView.insertSubview(self.circle, belowSubview: returngView)
            }
        }) { (success: Bool) in
            returngView.center = viewCenter
            returngView.removeFromSuperview()
            self.circle.removeFromSuperview()
            transitionContext.completeTransition(success)
        }
    }
    
}
