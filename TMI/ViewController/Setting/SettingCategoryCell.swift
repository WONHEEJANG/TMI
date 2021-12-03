
import UIKit

import SnapKit


class SettingCategoryCell: UICollectionViewCell {
    
    var CategoryImgView = UIImageView()
    var CategoryLabel = UILabel()
    
    let cellWidth = UIScreen.main.bounds.width * 0.15 // 디바이스 너비
    let cellHeight = UIScreen.main.bounds.height * 0.1 // 디바이스 높이
    var isTapped = false
    
    
    func updateData(){
        CategoryImgView.image = UIImage(named: "category-wine")
        CategoryLabel.text = "술"
    }
    
    func setupCell(){
        
        contentView.addSubview(CategoryImgView)
        contentView.addSubview(CategoryLabel)
        
        //        CategoryImgView.backgroundColor = .black
        //        CategoryLabel.backgroundColor = .green
        
        
        CategoryImgView.contentMode = .scaleAspectFit
        CategoryImgView.snp.makeConstraints { const in
            const.top.equalTo(contentView.snp.top)
            const.bottom.equalTo(CategoryLabel.snp.top)
            const.leading.equalTo(contentView.snp.leading)
            const.trailing.equalTo(contentView.snp.trailing)
        }
        
        CategoryLabel.textAlignment = .center
        CategoryLabel.snp.makeConstraints { const in
            const.bottom.equalTo(contentView.snp.bottom)
            const.height.equalTo(20)
            const.leading.equalTo(contentView.snp.leading)
            const.trailing.equalTo(contentView.snp.trailing)
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
