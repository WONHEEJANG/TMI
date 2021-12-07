
import UIKit

import SnapKit


class MyTMICell: UICollectionViewCell {
    
    var TMIView = UIView()
    var CategoryLabel = UILabel()
    var TMIEmojiLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    var TMIDescriptionLabel = UILabel()
    var TMIIndexPath : Int?
    
    let DeviceWidth = UIScreen.main.bounds.width
    let DeviceHeight = UIScreen.main.bounds.height
    
    func updateData(index:IndexPath, List:[TMI]){
        
        self.TMIEmojiLabel.text = List[index.row].emoji
        self.TMIDescriptionLabel.text = List[index.row].description
        self.CategoryLabel.text = List[index.row].topic
        self.TMIView.backgroundColor = self.TMIEmojiLabel.toImage?.averageColor
        
        print("TMIEmojiLabel.text:\(TMIEmojiLabel.text)")
        print("TMIView.backgroundColor:\(TMIView.backgroundColor)")
        
    }
    
    
    func setupCell(){
        
        contentView.addSubview(TMIView)
        TMIView.addSubview(CategoryLabel)
        TMIView.addSubview(TMIEmojiLabel)
        TMIView.addSubview(TMIDescriptionLabel)
        
        //        CategoryImgView.backgroundColor = .black
        //        CategoryLabel.backgroundColor = .green
        
        TMIView.clipsToBounds = true
        TMIView.layer.cornerRadius = 20
        TMIView.layer.shadowOpacity = 1
        TMIView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        TMIView.layer.shadowOffset = CGSize(width: 0, height: 4)
        TMIView.layer.shadowRadius = 2
        TMIView.layer.masksToBounds = false
        
        TMIEmojiLabel.clipsToBounds = true
        TMIEmojiLabel.backgroundColor = .white
        TMIEmojiLabel.layer.cornerRadius = 20
        TMIEmojiLabel.textAlignment = .center
        TMIEmojiLabel.font = CategoryLabel.font.withSize(30)
        
        TMIDescriptionLabel.numberOfLines = 2
        TMIDescriptionLabel.lineBreakMode = .byWordWrapping
        TMIDescriptionLabel.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 15)
        
        TMIView.snp.makeConstraints { const in
            const.leading.equalTo(contentView.snp.leading)
            const.trailing.equalTo(contentView.snp.trailing)
            const.top.equalTo(contentView.snp.top).offset(DeviceHeight * 0.005)
            const.bottom.equalTo(contentView.snp.bottom)
        }
        TMIEmojiLabel.snp.makeConstraints { const in
            const.centerY.equalTo(TMIView.snp.centerY)
            const.leading.equalTo(TMIView.snp.leading).offset(20)
            const.size.width.equalTo(50)
        }
        TMIDescriptionLabel.snp.makeConstraints { const in
            const.centerY.equalTo(TMIView.snp.centerY)
            const.leading.equalTo(TMIEmojiLabel.snp.trailing).offset(20)
            const.size.height.equalTo(DeviceHeight * 0.1)
            const.trailing.equalTo(TMIView.snp.trailing).offset(-20) //추가 21.11.24
        }
        
        CategoryLabel.snp.makeConstraints{(const) in
            const.top.equalTo(TMIView.snp.top).offset(10)
            const.trailing.equalTo(TMIView.snp.trailing).offset(-15) //추가 21.11.27
        }
        CategoryLabel.font = CategoryLabel.font.withSize(10)
        CategoryLabel.text = "언어"
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
            SettingCategoryCell.animate(withDuration: 0.5,
                                        delay: 0,
                                        usingSpringWithDamping: 1,
                                        initialSpringVelocity: 1,
                                        options: [.allowUserInteraction], animations: {
                self.transform = .init(scaleX: 0.9, y: 0.9)
                self.layoutIfNeeded()
            }, completion: nil)
        }
        else {
            print("false")
            SettingCategoryCell.animate(withDuration: 0.5,
                                        delay: 0,
                                        usingSpringWithDamping: 1,
                                        initialSpringVelocity: 0,
                                        options: .allowUserInteraction, animations: {
                self.transform = .identity
            }, completion: nil)
        }
    }
}
