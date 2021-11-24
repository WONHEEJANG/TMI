//
//  TrackCollectionHeaderView.swift
//  AppleMusicStApp
//
//  Created by joonwon lee on 2020/03/15.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
class TMICollectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var TodaysPickView: UIView!
    @IBOutlet weak var HeaderImgView: UIImageView!
    @IBOutlet weak var BestImgView: UIImageView!
    @IBOutlet weak var FollowingImgView: UIImageView!
    
    @IBOutlet weak var TMIEmojiLabel: UILabel!
    @IBOutlet weak var TMIDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        let cellWidth = UIScreen.main.bounds.width - 20 * 2 // 디바이스 사이즈
        
        HeaderImgView.snp.makeConstraints{(const) in
            const.top.equalToSuperview().offset(10)
            const.leading.equalToSuperview().offset(20)
            const.trailing.equalToSuperview().offset(-20)
            const.size.height.equalTo(self.frame.height / 4)
            const.bottom.equalTo(BestImgView.snp.top).offset(-10)
        }
        BestImgView.snp.makeConstraints{(const) in
            const.top.equalTo(HeaderImgView.snp.bottom).offset(20)
            const.leading.equalTo(HeaderImgView.snp.leading)
        }
        TodaysPickView.snp.makeConstraints{(const) in
            const.top.equalTo(BestImgView.snp.bottom).offset(10)
            const.leading.equalTo(HeaderImgView.snp.leading)
            const.trailing.equalTo(HeaderImgView.snp.trailing)
            
//            const.size.height.equalTo(self.frame.width / 4)
            const.width.equalTo(cellWidth) //추가 21.11.24
            const.height.equalTo(cellWidth / 3) //추가 21.11.24
        }
        TodaysPickView.clipsToBounds = true
        TodaysPickView.layer.cornerRadius = 20
        TodaysPickView.layer.borderWidth = 1
        TodaysPickView.layer.borderColor = UIColor.black.cgColor
        
        FollowingImgView.snp.makeConstraints{(const) in
            const.leading.equalTo(HeaderImgView.snp.leading)
            const.bottom.equalToSuperview().offset(-10)
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
