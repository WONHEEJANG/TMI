//
//  AppContentDissmisingAnimator.swift
//  AppStoreTransition
//
//  Created by UY on 2020/12/23.
//

import Foundation
import UIKit
import SnapKit

class DismissAnimator : NSObject, UIViewControllerAnimatedTransitioning {
    
    var targetIndexPath: IndexPath?
    //    var targetData: AppContentModel?
    var targetCellFrame: CGRect
    
    var subDescTopAnchor: NSLayoutConstraint!
    var subDescLeadingAnchor: NSLayoutConstraint!
    
    var descTopAnchor: NSLayoutConstraint!
    var descLeadingAnchor: NSLayoutConstraint!
    
    
    init(indexPath: IndexPath, cellFrame targetCellFrame: CGRect) {
        targetIndexPath = indexPath
        //        targetData = model[indexPath.row]
        self.targetCellFrame = targetCellFrame
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        guard let contentVC = transitionContext.viewController(forKey: .from) as? TMIDetailViewController else { fatalError() }
        guard let toVC = transitionContext.viewController(forKey: .to) as? TMITabBarViewController else { fatalError() }
        guard let appStoreMenuVC = toVC.viewControllers![0] as? FeedViewController else { fatalError() }
        guard let fromView = contentVC.view else { fatalError() }
        guard let toView = appStoreMenuVC.view else { fatalError() }
        
        let targetCell = appStoreMenuVC.TMICollectionView.cellForItem(at: targetIndexPath!) as! TMICollectionViewCell
        
        let targetTabbar = toVC.tabBar
        
        print("===DismissAnimator===")
//        var finalFrame = appStoreMenuVC.TMICollectionView.convert(targetCell.frame, to: toView)
        
        let finalFrame = targetCellFrame
        if toView.safeAreaInsets.top == 0 {
//            finalFrame.origin. += 20
        }
        targetCell.alpha = 0.0
        fromView.alpha = 0.0
        
        print("finalFrame : \(finalFrame)")
        
        let shadowView = UIView(frame: fromView.frame)
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.2
//        shadowView.layer.shadowOffset = .init(width: 0, height: 4)
        shadowView.layer.shadowOffset = .init(width: 0, height: 0)
        shadowView.layer.shadowRadius = 20
        
        //        let contentView = AppContentView(isContentView: true)
        let contentView = contentVC.TMIDetailContentView!
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = GlobalConstants.cornerRadius
        contentVC.closebutton.alpha = 0.0
        
        //        contentView.fetchDataForContentVC(image: targetData!.image, subD: targetData!.subDescription!, desc: targetData!.description!, content: targetData!.content!, contentView: fromView.frame, isTransition: true)
        
        containerView.addSubview(shadowView)
        shadowView.addSubview(contentView)
        
        
        contentView.snp.makeConstraints { (const) in
            const.top.equalTo(shadowView.snp.top)
            const.bottom.equalTo(shadowView.snp.bottom)
            const.leading.equalTo(shadowView.snp.leading)
            const.trailing.equalTo(shadowView.snp.trailing)
        }
        
        containerView.layoutIfNeeded()
        
        //        func reConfigureContentLabel() {
        //
        //            contentView.subDescriptionLabel.snp.remakeConstraints { (const) in
        //                const.top.equalTo(contentView.snp.top).offset(15)
        //                const.leading.equalTo(contentView.snp.leading).offset(15)
        //                const.width.equalTo(contentView.snp.width).multipliedBy(0.8)
        //            }
        //            contentView.descriptionLabel.snp.remakeConstraints { (const) in
        //                const.top.equalTo(contentView.subDescriptionLabel.snp.bottom).offset(10)
        //                const.leading.equalToSuperview().offset(15)
        //                const.width.equalTo(contentView.snp.width).multipliedBy(0.8)
        //            }
        //            contentView.imageView.snp.remakeConstraints { (const) in
        //                const.top.equalTo(contentView.snp.top)
        //                const.leading.equalTo(contentView.snp.leading)
        //                const.trailing.equalTo(contentView.snp.trailing)
        //                const.bottom.equalTo(contentView.snp.bottom)
        //            }
        //        }
        
        //        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveLinear) {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut) {
            //            reConfigureContentLabel()
            contentView.frame = finalFrame
            shadowView.frame = finalFrame
            
            
            toView.alpha = 1.0
            
            containerView.layoutIfNeeded()
            
        } completion: { [self] (comp) in
            
            let success = !transitionContext.transitionWasCancelled
            
            if !success {
                fromView.alpha = 1.0
                toView.removeFromSuperview()
            }
            //            toVC.reloadItems()
            
            targetCell.alpha = 1.0
            targetTabbar.alpha = 1.0
            appStoreMenuVC.TMICollectionView.cellForItem(at: targetIndexPath!)?.contentView.alpha = 1.0
            
            contentView.removeFromSuperview()
            transitionContext.completeTransition(success)
        }
        
    }
    
    
}
