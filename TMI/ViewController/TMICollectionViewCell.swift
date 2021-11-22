//
//  TrackCollectionViewCell.swift
//  AppleMusicStApp
//
//  Created by joonwon lee on 2020/01/12.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
import SnapKit


class TMICollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var TMIView: UIView!
    @IBOutlet weak var TMIDescriptionLabel: UILabel!
    @IBOutlet weak var TMIEmojiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //============TMIView============
        TMIView.clipsToBounds = true
        TMIView.layer.cornerRadius = 20
        TMIView.layer.borderWidth = 1
        TMIView.layer.borderColor = UIColor.black.cgColor
        TMIView.snp.makeConstraints{(const) in
            const.size.width.equalToSuperview()
        }
        //===============================
        
        //============TMIEmojiLabel============
        TMIEmojiLabel.snp.makeConstraints{(const) in
            const.centerY.equalToSuperview()
            const.leading.equalToSuperview().offset(20)
        }
        TMIEmojiLabel.backgroundColor = .white
        TMIEmojiLabel.clipsToBounds = true
        TMIEmojiLabel.layer.cornerRadius = 10
        TMIEmojiLabel.layer.borderWidth = 1
        TMIEmojiLabel.layer.borderColor = UIColor.black.cgColor
        //=====================================
    
        //============TMIDescriptionLabel============
        TMIDescriptionLabel.snp.makeConstraints{(const) in
            const.centerY.equalTo(TMIEmojiLabel.snp.centerY)
            const.leading.equalTo(TMIEmojiLabel.snp.trailing).offset(20)
//            const.trailing.equalTo(self.snp.trailing).offset(-20)
        }
        TMIDescriptionLabel.lineBreakMode = .byWordWrapping
        //===========================================
    }
    
    //=================================TOUCH & BOUNCE======================================
    
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           super.touchesBegan(touches, with: event)
           print("touchsBegan")
           bounceAnimate(isTouched: true)
       }
       
       override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
           super.touchesEnded(touches, with: event)
           print("touchesEnded")
           bounceAnimate(isTouched: false)
       }
       
       override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
           super.touchesCancelled(touches, with: event)
           print("touchesCancelled")
           bounceAnimate(isTouched: false)
       }
       
       private func bounceAnimate(isTouched: Bool) {
           
           if isTouched {
               print("true")
               TMICollectionViewCell.animate(withDuration: 0.5,
                              delay: 0,
                              usingSpringWithDamping: 1,
                              initialSpringVelocity: 1,
                              options: [.allowUserInteraction], animations: {
                               self.transform = .init(scaleX: 0.96, y: 0.96)
                               self.layoutIfNeeded()
                              }, completion: nil)
           } else {
               print("false")
               TMICollectionViewCell.animate(withDuration: 0.5,
                              delay: 0,
                              usingSpringWithDamping: 1,
                              initialSpringVelocity: 0,
                              options: .allowUserInteraction, animations: {
                               self.transform = .identity
                              }, completion: nil)
           }
       }
    
    @objc func handleTap(sender: UITapGestureRecognizer)
    {
        print("tap")
        
    }
}
