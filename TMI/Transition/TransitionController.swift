//
//  TransitionController.swift
//  TMI
//
//  Created by Jason on 2021/11/19.
//

import Foundation
import UIKit

class TransitionController:NSObject, UIViewControllerTransitioningDelegate{
    
    var superViewController: UIViewController?
    var indexPath: IndexPath?
    var targetCellFrame: CGRect?
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return Presentation(presentedViewController: presented, presenting: presenting)
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentingAnimator(indexPath: indexPath!)
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        print("TransitionController")
        print("indexPath : \(indexPath)")
        print("targetCellFrame : \(targetCellFrame)")
        
        return DismissAnimator(indexPath: indexPath!, cellFrame: targetCellFrame!)
    }
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        nil
    }
}
