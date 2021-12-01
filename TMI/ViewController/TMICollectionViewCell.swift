
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
    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var TMIEmojiLabel: UILabel!
    @IBOutlet weak var TMIDescriptionLabel: UILabel!
    @IBOutlet weak var ProfileImgView: UIImageView!
        
    let cellWidth = UIScreen.main.bounds.width - 20 * 2 // 디바이스 사이즈
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        set_collectionViewCell()
        updateData()
    }
    
    func updateData(){
        CategoryLabel.text = "언어"
        ProfileImgView.image = UIImage(named: "profile-sample")
    }
    
    func set_collectionViewCell(){
        set_TMIView()
        set_CategoryLabel()
        set_TMIEmojiLabel()
        set_TMIDescriptionLabel()
        set_ProfileImgView()
    }
    
    func set_TMIView(){
        TMIView.clipsToBounds = true
        TMIView.layer.cornerRadius = 20
        TMIView.layer.borderWidth = 1
        TMIView.layer.borderColor = UIColor.black.cgColor
    
        TMIView.snp.makeConstraints{(const) in
            const.top.leading.trailing.equalToSuperview()
            const.bottom.equalToSuperview().offset(-15)
            const.width.equalTo(cellWidth) //추가 21.11.24
            print(self.bounds.width)
            print("cellWidth : \(cellWidth)")
        }
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
        TMIEmojiLabel.textAlignment = .center
    }
    func set_TMIDescriptionLabel(){
        TMIDescriptionLabel.snp.makeConstraints{(const) in
            const.centerY.equalTo(TMIEmojiLabel.snp.centerY)
            const.leading.equalTo(TMIEmojiLabel.snp.trailing).offset(20)
            const.trailing.equalTo(TMIView.snp.trailing).offset(-20) //추가 21.11.24
        }
        TMIDescriptionLabel.backgroundColor = .none
    }
    func set_CategoryLabel(){
        CategoryLabel.snp.makeConstraints{(const) in
            const.top.equalTo(TMIView.snp.top).offset(10)
            const.trailing.equalTo(TMIView.snp.trailing).offset(-15) //추가 21.11.27
        }
        CategoryLabel.font = CategoryLabel.font.withSize(10)
        CategoryLabel.text = "언어"
    }
    func set_ProfileImgView(){
        ProfileImgView.image = UIImage(named: "profile-sample")
        ProfileImgView.snp.makeConstraints{(const) in
            const.bottom.equalTo(TMIView.snp.bottom).offset(15)
            const.trailing.equalTo(TMIView.snp.trailing).offset(-10) //추가 21.11.27
            const.width.equalTo(30)
            const.height.equalTo(30)
        }
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
        }
        else {
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
