//
//  ViewController.swift
//  TMI
//
//  Created by NHDIC-BMT2 on 2021/11/08.
//

import UIKit
import SnapKit

class SettingCategoryVC: UIViewController,UITextFieldDelegate {
    let DeviceHeight = UIScreen.main.bounds.height
    let DeviceWidth = UIScreen.main.bounds.width
    var isFirst : Bool = true
    
    var TitleLabel = UILabel()
    var SubTitleLabel = VerticalAlignLabel()
    var CategoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCollectionView()
        collectionViewDelegate()
        
        
        self.view.addSubview(TitleLabel)
        self.view.addSubview(SubTitleLabel)
        self.view.addSubview(CategoryCollectionView)
        
//        TitleLabel.backgroundColor = .red
//        SubTitleLabel.backgroundColor = .orange
//        CategoryCollectionView.backgroundColor = .blue
        
        
        
        TitleLabel.text = "🍞➕🧀"
        TitleLabel.font = TitleLabel.font.withSize(40)
        
        TitleLabel.snp.makeConstraints { const in
            const.top.equalTo(view.snp.top).offset(DeviceHeight * 0.1)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.8, height: DeviceHeight * 0.05))
            const.left.equalTo(view.snp.left).offset(DeviceWidth * 0.1)
        }
        
        SubTitleLabel.verticalAlignment = .top
        SubTitleLabel.text = "쓸모는 딱히 없는데..\n괜히 알고싶은 분야 있으세요?"
        SubTitleLabel.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 22)
        SubTitleLabel.numberOfLines = 3
        SubTitleLabel.lineBreakMode = .byTruncatingTail
        
        
        SubTitleLabel.snp.makeConstraints { const in
            const.top.equalTo(TitleLabel.snp.bottom).offset(DeviceHeight * 0.05)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.8, height: DeviceHeight * 0.1))
            const.left.equalTo(TitleLabel.snp.left)
        }
        
        CategoryCollectionView.snp.makeConstraints{ const in
            const.top.equalTo(SubTitleLabel.snp.bottom).offset(DeviceHeight * 0.05)
            const.leading.equalTo(SubTitleLabel.snp.leading)
            const.trailing.equalTo(SubTitleLabel.snp.trailing)
            const.bottom.equalTo(view.snp.bottom)
        }
    }
    func registerCollectionView() {
        CategoryCollectionView.register(SettingCategoryCell.classForCoder(), forCellWithReuseIdentifier: "SettingCategoryCell")
    }
    func collectionViewDelegate() {
        CategoryCollectionView.delegate = self
        CategoryCollectionView.dataSource = self
    }
}

extension SettingCategoryVC: UICollectionViewDataSource {
    // 몇개 표시 할까?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    // 셀 어떻게 표시 할까?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SettingCategoryCell", for: indexPath) as? SettingCategoryCell else {
            return UICollectionViewCell()
        }
        cell.updateData()
        cell.setupCell()
//        cell.backgroundColor = .yellow
        
        return cell
    }
}

extension SettingCategoryVC: UICollectionViewDelegate {
    // 클릭했을때 어떻게 할까?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("tap => \(indexPath)")
        
        let cell = collectionView.cellForItem(at: indexPath) as! SettingCategoryCell
        
        
        
        if(cell.isTapped){
            cell.isTapped = false
            cell.alpha = 1
        }
        else{
            cell.isTapped = true
            cell.alpha = 0.2
        }
        print("cell.isTapped : \(cell.isTapped)")
    }
}

extension SettingCategoryVC: UICollectionViewDelegateFlowLayout {
    // 셀 사이즈 어떻게 할까?
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 0.1 - card(width) - 0.01 - card(width) - 0.01 - card(width) - 0.01 - card(width) - 0.1
        
        let width: CGFloat = UIScreen.main.bounds.width * 0.15 // 디바이스 너비
        let height: CGFloat = UIScreen.main.bounds.height * 0.12 // 디바이스 높이
        return CGSize(width: width, height: height)
    }
}
