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
        //======여기 밑에는 로그인으로 들어오고 =====
        //======여기 밑에는 로그인으로 들어오고 =====
        //======여기 밑에는 로그인으로 들어오고 =====
    
//        guard let SettingNaviC = transitionContext.viewController(forKey: .to) as? SettingNaviController else {fatalError()}
//        guard let toVC = SettingNaviC.topViewController as? TMITabBarViewController else {fatalError()}
        
        //======여기 밑에는 로그인으로 안들어오고 처음부터 Feed들어오면 밑에꺼로 해야됌 =====
        //======여기 밑에는 로그인으로 안들어오고 처음부터 Feed들어오면 밑에꺼로 해야됌 =====
        //======여기 밑에는 로그인으로 안들어오고 처음부터 Feed들어오면 밑에꺼로 해야됌 =====
        
        
//        guard let toVC = transitionContext.viewController(forKey: .to) as? TMITabBarViewController else { fatalError() }
       
        var toVC : TMITabBarViewController!
        
        if let SettingNaviC = transitionContext.viewController(forKey: .to) as? SettingNaviController {
            toVC = SettingNaviC.topViewController as? TMITabBarViewController
        }
        else {
            toVC = transitionContext.viewController(forKey: .to) as? TMITabBarViewController
        }
        
        guard let appStoreMenuVC = toVC.viewControllers![0] as? FeedViewController else { fatalError() }
        guard let fromView = contentVC.view else { fatalError() }
        guard let toView = appStoreMenuVC.view else { fatalError() }
        
        let targetCell = appStoreMenuVC.TMICollectionView.cellForItem(at: targetIndexPath!) as! TMICollectionViewCell
        
        let targetTabbar = toVC.tabBar
        
        print("===DismissAnimator===")
        
        var finalFrame = targetCellFrame // 12.01 추가
        finalFrame.size.height += 15 // 12.01 추가
        
        if toView.safeAreaInsets.top == 0 {
            //            finalFrame.origin. += 20
        }
        targetCell.alpha = 0.0
        fromView.alpha = 0.0
        
        print("finalFrame : \(finalFrame)")
        
        let shadowView = UIView(frame: fromView.frame)
        shadowView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = .init(width: 0, height: 4)
        shadowView.layer.shadowRadius = 2
        
        let contentView = contentVC.TMIDetailContentView!
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = GlobalConstants.cornerRadius
        contentVC.closebutton.alpha = 0.0

        
        containerView.addSubview(shadowView)
        shadowView.addSubview(contentView)
        
        
        contentView.snp.makeConstraints { (const) in
            const.top.equalTo(shadowView.snp.top)
            const.bottom.equalTo(shadowView.snp.bottom)
            const.leading.equalTo(shadowView.snp.leading)
            const.trailing.equalTo(shadowView.snp.trailing)
        }
        
        let VIEW_top_to_EMOJI_top_distance_in_Cell = targetCell.TMIEmojiLabel.frame.minY - targetCell.TMIView.frame.minY
        let VTEW_leading_to_DESC_leading_distance_in_Cell = targetCell.TMIDescriptionLabel.frame.minX - targetCell.TMIView.frame.minX
        let VTEW_trailing_to_DESC_trailing_distance_in_Cell = targetCell.TMIView.frame.maxX - targetCell.TMIDescriptionLabel.frame.maxX
        print("top to emoji distance in Cell :\(VIEW_top_to_EMOJI_top_distance_in_Cell)")
        
        
        contentVC.TMIDetailViewDescriptionLabel.snp.remakeConstraints{(const) in
            const.centerY.equalTo(contentVC.TMIDetailViewEmojiLabel.snp.centerY)
            const.leading.equalToSuperview().offset(VTEW_leading_to_DESC_leading_distance_in_Cell)
            const.trailing.equalToSuperview().offset(-1 * VTEW_trailing_to_DESC_trailing_distance_in_Cell)
        }
        
        contentVC.TMIDetailViewDescriptionLabel.font = contentVC.TMIDetailViewDescriptionLabel.font.withSize(15)
        contentVC.TMIDetailViewEmojiLabel.backgroundColor = .white
        contentVC.TMIDetailViewEmojiLabel.layer.cornerRadius = 20
    
        
        
        contentVC.TMIDetailViewDescriptionLabel.snp.remakeConstraints{(const) in
            const.centerY.equalTo(contentVC.TMIDetailViewEmojiLabel.snp.centerY)
            const.leading.equalToSuperview().offset(VTEW_leading_to_DESC_leading_distance_in_Cell)
            const.trailing.equalToSuperview().offset(-1 * VTEW_trailing_to_DESC_trailing_distance_in_Cell)
        }
        
        contentVC.TMIDetailCardView.snp.remakeConstraints { (const) in
            const.top.equalTo(shadowView.snp.top)
            const.bottom.equalTo(shadowView.snp.bottom).offset(-15)
            const.leading.equalTo(shadowView.snp.leading)
            const.trailing.equalTo(shadowView.snp.trailing)
        }
        contentVC.TMIDetailCardView.layer.cornerRadius = 20
        contentVC.TMIDetailCardView.layer.backgroundColor = contentVC.TMIDetailContentView.layer.backgroundColor
//
//        contentVC.TMIDetailCardView.layer.shadowOpacity = 1
//        contentVC.TMIDetailCardView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//        contentVC.TMIDetailCardView.layer.shadowOffset = CGSize(width: 0, height: 4)
//        contentVC.TMIDetailCardView.layer.shadowRadius = 2
//
//        contentVC.TMIDetailCardView.layer.masksToBounds = false
//
        
        
        
        contentVC.TMIDetailContentView.layer.borderWidth = 0
        contentVC.TMIDetailContentView.layer.backgroundColor = .none
        
        contentVC.CategoryLabel.snp.remakeConstraints { (const) in
            const.top.equalTo(shadowView.snp.top).offset(10)
            const.trailing.equalTo(shadowView.snp.trailing).offset(-15) //추가 21.11.27
            
        }
        contentVC.CategoryLabel.font = contentVC.CategoryLabel.font.withSize(10)
        
        
        contentVC.ProfileImgView.snp.remakeConstraints{(const) in
            const.bottom.equalTo(shadowView.snp.bottom) // 15
            const.trailing.equalTo(shadowView.snp.trailing).offset(-10) // -10
            const.width.equalTo(30)
            const.height.equalTo(30)
        }
        contentVC.AddingView.alpha = 0
        
        contentVC.ProfileImgView.clipsToBounds = true
        
        
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut) {
            contentView.frame = finalFrame
            shadowView.frame = finalFrame
            toView.alpha = 1.0

        } completion: { [self] (comp) in
            
            let success = !transitionContext.transitionWasCancelled
            
            if !success {
                fromView.alpha = 1.0
                toView.removeFromSuperview()
            }
            
            targetCell.alpha = 1.0
            targetTabbar.alpha = 1.0
            appStoreMenuVC.TMICollectionView.cellForItem(at: targetIndexPath!)?.contentView.alpha = 1.0
            
            contentView.removeFromSuperview()
            transitionContext.completeTransition(success)
        }
        
    }
    
    
}
