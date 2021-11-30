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
        //        containerView.alpha = 1.0
        
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
        contentVC.TMIDetailView.layer.cornerRadius = 20
        contentVC.TMIDetailView.translatesAutoresizingMaskIntoConstraints = false
        
        
        containerView.addSubview(toView)
        containerView.addSubview(contentVC.TMIDetailView)
        
        //        targetCell.transform = .identity
        
        NSLayoutConstraint.activate(makeConstraints(containerView: containerView, contentView: contentVC.TMIDetailView, Originframe: startFrame))
        containerView.layoutIfNeeded()
        
        // ========================================================================//
        
        //MARK:- TopConstraints Animation
        let TOPANCHOR_CONSTANT = UIScreen.main.bounds.height / 4 // (디바이스 사이즈 - TMI DETAIL뷰)
        
        contentViewTopAnchor.constant = TOPANCHOR_CONSTANT // TOP과 POUP과의 거리
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveLinear, animations: {
            contentVC.TMIDetailView.layoutIfNeeded()
        }) { (comp) in
            //                   toView.alpha = 1.0
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        //MARK:- View's Height and Width Animation
        
        contentViewWidthAnchor.constant = containerView.frame.width
        contentViewHeightAnchor.constant = containerView.frame.height
        
        let VIEW_top_to_EMOJI_top_distance_in_Cell = targetCell.TMIEmojiLabel.frame.minY - targetCell.TMIView.frame.minY
        let VTEW_leading_to_DESC_leading_distance_in_Cell = targetCell.TMIDescriptionLabel.frame.minX - targetCell.TMIView.frame.minX
        let VTEW_trailing_to_DESC_trailing_distance_in_Cell = targetCell.TMIView.frame.maxX - targetCell.TMIDescriptionLabel.frame.maxX + 20 * 2
        print("top to emoji distance in Cell :\(VIEW_top_to_EMOJI_top_distance_in_Cell)")
        
        contentVC.TMIDetailViewEmojiLabel.snp.remakeConstraints { (const) in
            const.top.equalToSuperview().offset(VIEW_top_to_EMOJI_top_distance_in_Cell)
            const.leading.equalToSuperview().offset(20)
            const.width.height.equalTo(50) //추가 21.11.24
            
        }
        contentVC.TMIDetailViewDescriptionLabel.snp.remakeConstraints { (const) in
            const.leading.equalTo(contentVC.TMIDetailViewEmojiLabel.snp.leading)
            const.top.equalTo(contentVC.TMIDetailViewEmojiLabel.snp.bottom).offset(20)
        }
        contentVC.TMIDetailViewDescriptionLabel.font = contentVC.TMIDetailViewDescriptionLabel.font.withSize(20)
        
        
        contentVC.CategoryLabel.snp.remakeConstraints { (const) in
            const.top.equalTo(contentVC.TMIDetailContentView.snp.top).offset(10)
            const.trailing.equalTo(contentVC.TMIDetailContentView.snp.trailing).offset(-15) //추가 21.11.27
        }
        contentVC.CategoryLabel.font = contentVC.CategoryLabel.font.withSize(10)
        contentVC.CategoryLabel.text = "언어"
        
        contentVC.ProfileImgView.snp.remakeConstraints { (const) in
            const.bottom.equalTo(contentVC.TMIDetailContentView.snp.bottom).offset(-25)
            const.trailing.equalTo(contentVC.TMIDetailContentView.snp.trailing).offset(-25) //추가 21.11.27
            const.width.equalTo(50)
            const.height.equalTo(50)
        }
        contentVC.ProfileImgView.image = UIImage(named: "profile-sample")
        
        
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
