//
//  TrackCollectionViewCell.swift
//  AppleMusicStApp
//
//  Created by joonwon lee on 2020/01/12.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit


class TMICollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var TMIView: UIView!
    @IBOutlet weak var TMIDescriptionLabel: UILabel!
    @IBOutlet weak var TMIEmojiLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //TMIView 라운드 설정
        TMIView.roundCorners(cornerRadius: 40, maskedCorners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner])
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


//
//class TMICollectionViewCell: UICollectionViewCell {
//    @IBOutlet weak var trackThumbnail: UIImageView!
//    @IBOutlet weak var trackTitle: UILabel!
//    @IBOutlet weak var trackArtist: UILabel!
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        trackThumbnail.layer.cornerRadius = 4
//        trackArtist.textColor = UIColor.systemGray2
//    }
//
//    func updateUI(item: Track?) {
//        guard let track = item else { return }
//        trackThumbnail.image = track.artwork
//        trackTitle.text = track.title
//        trackArtist.text = track.artist
//    }
//}
