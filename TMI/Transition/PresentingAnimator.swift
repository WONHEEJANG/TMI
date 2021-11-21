//
//  PresentingAnimator.swift
//  TMI
//
//  Created by Jason on 2021/11/19.
//

import Foundation
import UIKit
import SnapKit

class PresentingAnimator : NSObject, UIViewControllerAnimatedTransitioning{
    
    var contentViewTopAnchor: NSLayoutConstraint!
    var contentViewWidthAnchor: NSLayoutConstraint!
    var contentViewHeightAnchor: NSLayoutConstraint!
    var contentViewCenterXAnchor: NSLayoutConstraint!
    
    var subDescTopAnchor: NSLayoutConstraint!
    var subDescLeadingAnchor: NSLayoutConstraint!
    
    var descTopAnchor: NSLayoutConstraint!
    var descLeadingAnchor: NSLayoutConstraint!
    
    
    var targetIndexPath: IndexPath?
    
    init(indexPath: IndexPath) {
            super.init()
            targetIndexPath = indexPath
        }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        containerView.alpha = 1.0
        
//        guard let fromVC = transitionContext.viewController(forKey: .from) as? FeedViewController else {fatalError()}
        guard let fromVC = transitionContext.viewController(forKey: .from) as? TMITabBarViewController else {fatalError()}
        guard let feedVC = fromVC.children[0] as? FeedViewController else {fatalError()}
        guard let contentVC = transitionContext.viewController(forKey: .to) as? TMIDetailViewController else {fatalError()}
        
        guard let fromView = fromVC.view else {fatalError()}
        guard let toView = contentVC.view else {fatalError()}
        
        let targetCell = feedVC.TMICollectionView.cellForItem(at: targetIndexPath!) as! TMICollectionViewCell
        let startFrame = feedVC.TMICollectionView.convert(targetCell.frame, to: fromView)
        // ============================ 얘네가 데이터 받는거임 ==========================//
        contentVC.TMIDetailViewEmojiLabel.text = TMIList[targetIndexPath!.row].emoji
        contentVC.TMIDetailViewDescriptionLabel.text = TMIList[targetIndexPath!.row].description
        // ========================================================================//
        
        // =========================== 여기부터 디테일 뷰 그리기 ========================//
        contentVC.TMIDetailView.clipsToBounds = true
        contentVC.TMIDetailView.layer.cornerRadius = 40
        contentVC.TMIDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        toView.alpha = 0.0
        contentVC.TMIDetailView.alpha = 1.0
        targetCell.alpha = 0.0
        
        containerView.addSubview(toView)
        containerView.addSubview(contentVC.TMIDetailView)
        
        targetCell.transform = .identity
        
        NSLayoutConstraint.activate(makeConstraints(containerView: containerView, contentView: contentVC.TMIDetailView, Originframe: startFrame))
        containerView.layoutIfNeeded()
        
        // ========================================================================//
        
        //MARK:- TopConstraints Animation

               contentViewTopAnchor.constant = 0

               UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveLinear, animations: {
                   contentVC.TMIDetailView.layoutIfNeeded()
               }) { (comp) in
                   toView.alpha = 1.0
//                   contentVC.TMIDetailView.removeFromSuperview()
                   transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
               }

        //MARK:- View's Height and Width Animation

                contentViewWidthAnchor.constant = containerView.frame.width
                contentViewHeightAnchor.constant = containerView.frame.height

        contentVC.TMIDetailViewEmojiLabel.snp.remakeConstraints { (const) in
//                    const.top.equalTo(contentVC.TMIDetailView.snp.top).offset(GlobalConstants.safeAreaLayoutTop)
                    const.top.equalToSuperview().offset(50)
                    const.leading.equalTo(contentVC.TMIDetailView.snp.leading).offset(20)
                    const.width.equalTo(contentVC.TMIDetailView.snp.width).multipliedBy(0.8)
                }
        contentVC.TMIDetailViewDescriptionLabel.snp.remakeConstraints { (const) in
                    const.top.equalTo(contentVC.TMIDetailViewEmojiLabel.snp.bottom).offset(10)
                    const.leading.equalToSuperview().offset(20)
                    const.width.equalTo(contentVC.TMIDetailView.snp.width).multipliedBy(0.8)
                }

                UIView.animate(withDuration: 0.6 * 0.6) {

                    contentVC.TMIDetailView.layer.cornerRadius = 20
                    containerView.layoutIfNeeded()
                }
        
    }
    func makeConstraints(containerView: UIView, contentView: UIView, Originframe: CGRect) -> [NSLayoutConstraint] {
        
        contentViewCenterXAnchor = contentView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        contentViewTopAnchor = contentView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Originframe.minY)
        contentViewHeightAnchor = contentView.heightAnchor.constraint(equalToConstant: Originframe.height * 2)
        contentViewWidthAnchor = contentView.widthAnchor.constraint(equalToConstant: Originframe.width)
        
        return [contentViewCenterXAnchor, contentViewTopAnchor, contentViewHeightAnchor, contentViewWidthAnchor]
        
    }
    
}
