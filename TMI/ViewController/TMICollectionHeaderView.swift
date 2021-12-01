//
//  TrackCollectionHeaderView.swift
//  AppleMusicStApp
//
//  Created by joonwon lee on 2020/03/15.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
class TMICollectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var HeaderImgView: UIImageView!
    @IBOutlet weak var BestImgView: UIImageView!
    @IBOutlet weak var TodaysPickView: UIView!
    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var TMIEmojiLabel: UILabel!
    @IBOutlet weak var TMIDescriptionLabel: UILabel!
    @IBOutlet weak var ProfileImgView: UIImageView!
    @IBOutlet weak var FollowingImgView: UIImageView!
    
    let HeaderWidth = UIScreen.main.bounds.width - 20 * 2 // 디바이스 사이즈
    let HeaderHeight = UIScreen.main.bounds.width - 20 * 2
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("HeaderWidth : \(HeaderWidth)")
        print("HeaderHeight : \(HeaderHeight)")

        set_CollectionHeaderView()
        updateData()
        
    }
    
    func updateData(){
        CategoryLabel.text = "언어"
        
        ProfileImgView.image = UIImage(named: "profile-sample")
    }
    func set_CollectionHeaderView(){
        set_HeaderImgView()
        set_BestImgView()
        set_TodaysPickView()
        set_CategoryLabel()
        set_TMIEmojiLabel()
        set_TMIDescriptionLabel()
        set_ProfileImgView()
        set_FollowingImgView()
    }
    func set_HeaderImgView(){
        HeaderImgView.snp.makeConstraints{(const) in
            const.top.equalToSuperview().offset(HeaderHeight * 0.05)
            const.leading.equalToSuperview().offset(20)
            const.trailing.equalToSuperview().offset(-20)
            const.height.equalTo(HeaderHeight * 0.3)
        }
    }
    func set_BestImgView(){
        BestImgView.snp.makeConstraints{(const) in
            const.top.equalTo(HeaderImgView.snp.bottom).offset(HeaderHeight * 0.05)
            const.leading.equalTo(HeaderImgView.snp.leading)
            const.height.equalTo(HeaderHeight * 0.1)
            const.width.equalTo(HeaderHeight * 0.1 * 2.58)
        }
    }
    func set_TodaysPickView(){
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
    }
    func set_TMIEmojiLabel(){
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
    }
    func set_TMIDescriptionLabel(){
        TMIDescriptionLabel.snp.makeConstraints{(const) in
            const.centerY.equalTo(TMIEmojiLabel.snp.centerY)
        
            const.leading.equalTo(TMIEmojiLabel.snp.trailing).offset(20)
            
            const.trailing.equalTo(TodaysPickView.snp.trailing).offset(-20) //추가 21.11.24
        }
        
        TMIDescriptionLabel.lineBreakMode = .byWordWrapping
        TMIDescriptionLabel.backgroundColor = .none
    }
    func set_CategoryLabel(){
        
        CategoryLabel.snp.makeConstraints{(const) in
            const.top.equalTo(TodaysPickView.snp.top).offset(10)
            const.trailing.equalTo(TodaysPickView.snp.trailing).offset(-15) //추가 21.11.27
        }
        CategoryLabel.font = CategoryLabel.font.withSize(10)
    }
    func set_ProfileImgView(){
        ProfileImgView.snp.makeConstraints{(const) in
            const.bottom.equalTo(TodaysPickView.snp.bottom).offset(15)
            
            const.trailing.equalTo(TodaysPickView.snp.trailing).offset(-10) //추가 21.11.27
            const.width.equalTo(30)
            const.height.equalTo(30)
        }
    }
    func set_FollowingImgView(){
        FollowingImgView.snp.makeConstraints{(const) in
            const.top.equalTo(TodaysPickView.snp.bottom).offset(HeaderHeight * 0.05)
            const.leading.equalTo(HeaderImgView.snp.leading)
            const.height.equalTo(HeaderHeight * 0.1)
            const.width.equalTo(HeaderHeight * 0.1 * 4.55)
            const.bottom.equalToSuperview().offset(HeaderHeight * -0.05)
        }

    }
}
