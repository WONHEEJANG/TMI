//
//  TrackCollectionHeaderView.swift
//  AppleMusicStApp
//
//  Created by joonwon lee on 2020/03/15.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
class TMICollectionHeaderView: UICollectionReusableView {
                                                    //0.05
    @IBOutlet weak var HeaderImgView: UIImageView! // 0.2
                                                    //0.05
    @IBOutlet weak var BestImgView: UIImageView!    // 0.1
                                                    //0.05
    @IBOutlet weak var TodaysPickView: UIView!      // 0.4
    @IBOutlet weak var FollowingImgView: UIImageView! // 0.1
    
    @IBOutlet weak var TMIEmojiLabel: UILabel!
    @IBOutlet weak var TMIDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let HeaderWidth = UIScreen.main.bounds.width - 20 * 2 // 디바이스 사이즈
        let HeaderHeight = HeaderWidth
        
        print("HeaderWidth : \(HeaderWidth)")
        print("HeaderHeight : \(HeaderHeight)")
        
        HeaderImgView.snp.makeConstraints{(const) in
            const.top.equalToSuperview().offset(HeaderHeight * 0.05)
            const.leading.equalToSuperview().offset(20)
            const.trailing.equalToSuperview().offset(-20)
            const.height.equalTo(HeaderHeight * 0.3)
        }
        BestImgView.snp.makeConstraints{(const) in
            const.top.equalTo(HeaderImgView.snp.bottom).offset(HeaderHeight * 0.05)
            const.leading.equalTo(HeaderImgView.snp.leading)
            const.height.equalTo(HeaderHeight * 0.1)
            const.width.equalTo(HeaderHeight * 0.1 * 2.58)
        }
        TodaysPickView.snp.makeConstraints{(const) in
            const.top.equalTo(BestImgView.snp.bottom).offset(HeaderHeight * 0.05)
            const.leading.equalTo(HeaderImgView.snp.leading)
            const.trailing.equalTo(HeaderImgView.snp.trailing)
            const.height.equalTo(HeaderHeight * 0.4)
            const.width.equalTo(HeaderWidth)
        }
        TodaysPickView.clipsToBounds = true
        TodaysPickView.layer.cornerRadius = 20
        TodaysPickView.layer.borderWidth = 1
        TodaysPickView.layer.borderColor = UIColor.black.cgColor
        
        FollowingImgView.snp.makeConstraints{(const) in
            const.top.equalTo(TodaysPickView.snp.bottom).offset(HeaderHeight * 0.05)
            const.leading.equalTo(HeaderImgView.snp.leading)
            const.height.equalTo(HeaderHeight * 0.1)
            const.width.equalTo(HeaderHeight * 0.1 * 4.55)
            const.bottom.equalToSuperview().offset(HeaderHeight * -0.05)
        }
        
        //============TMIEmojiLabel============
        TMIEmojiLabel.snp.makeConstraints{(const) in
            const.centerY.equalToSuperview()
            
            const.leading.equalToSuperview().offset(20)
            
            const.width.height.equalTo(50) //추가 21.11.24
        }
        TMIEmojiLabel.backgroundColor = .white
        TMIEmojiLabel.clipsToBounds = true
        TMIEmojiLabel.layer.cornerRadius = 10
        TMIEmojiLabel.layer.borderWidth = 1
        TMIEmojiLabel.layer.borderColor = UIColor.black.cgColor
        TMIEmojiLabel.textAlignment = .center //추가 21.11.24
        //=====================================
        
        //============TMIDescriptionLabel============
        TMIDescriptionLabel.snp.makeConstraints{(const) in
            const.centerY.equalTo(TMIEmojiLabel.snp.centerY)
            
            const.leading.equalTo(TMIEmojiLabel.snp.trailing).offset(20)
            
            const.trailing.equalTo(TodaysPickView.snp.trailing).offset(-20) //추가 21.11.24
        }
        
        TMIDescriptionLabel.lineBreakMode = .byWordWrapping
        //===========================================
    }
}
