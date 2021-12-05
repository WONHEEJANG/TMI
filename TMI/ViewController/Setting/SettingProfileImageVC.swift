//
//  ViewController.swift
//  TMI
//
//  Created by NHDIC-BMT2 on 2021/11/08.
//

import UIKit
import SnapKit

class SettingProfileImageVC: UIViewController,UITextFieldDelegate {
    let DeviceHeight = UIScreen.main.bounds.height
    let DeviceWidth = UIScreen.main.bounds.width
    var isFirst : Bool = true
    
    var TitleLabel = UILabel()
    var SoonLabel = UILabel()
    var SubTitleLabel = VerticalAlignLabel()
    var DescriptionLabel = VerticalAlignLabel()
    var profileImgView = UIImageView()
    var NameLabel = UILabel()
    var ConfirmBtn = UIButton(type: .system)
    var BackBtn = UIButton(type: .system)
    
    
    let updateImg = UIImage(named: "icon-plus")
    var updateImgBtn = UIButton()
    var alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let imagePicker = UIImagePickerController()
    let ALERT_FailToTakePhoto = UIAlertController(title: "Missing camera", message: "You can't take photo, there is no camera.", preferredStyle: UIAlertController.Style.alert)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker.allowsEditing = true // 수정 가능 여부
        self.imagePicker.delegate = self // picker delegate
        
        self.view.addSubview(TitleLabel)
        self.view.addSubview(SoonLabel)
        self.view.addSubview(SubTitleLabel)
        self.view.addSubview(DescriptionLabel)
        self.view.addSubview(profileImgView)
        self.view.addSubview(NameLabel)
        self.view.addSubview(updateImgBtn)
        self.view.addSubview(ConfirmBtn)
        self.view.addSubview(BackBtn)
        
        
        //        TitleLabel.backgroundColor = .red
        //        SoonLabel.backgroundColor = .blue
        //        SubTitleLabel.backgroundColor = .orange
        //        DescriptionLabel.backgroundColor = .green
        //        updateImgBtn.backgroundColor = .darkGray
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.tabBarItem = nil
        TitleLabel.text = "🍞➕🧀➕🍅➕🥑"
        TitleLabel.font = TitleLabel.font.withSize(25)
        
        TitleLabel.snp.makeConstraints { const in
            const.top.equalTo(view.snp.top).offset(DeviceHeight * 0.1)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.6, height: DeviceHeight * 0.05))
            const.left.equalTo(view.snp.left).offset(DeviceWidth * 0.1)
        }
        
        SoonLabel.text = "🔜"
        SoonLabel.font = SoonLabel.font.withSize(25)
        SoonLabel.textAlignment = .right
        
        
        SoonLabel.snp.makeConstraints { const in
            const.top.equalTo(view.snp.top).offset(DeviceHeight * 0.1)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.1, height: DeviceHeight * 0.05))
            const.right.equalTo(view.snp.right).offset(DeviceWidth * -0.1)
        }
        
        SubTitleLabel.verticalAlignment = .top
        SubTitleLabel.text = "우연히 알게된 TMI가 있으면\n직접 남겨주세요."
        SubTitleLabel.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 22)
        SubTitleLabel.numberOfLines = 2
        
        SubTitleLabel.snp.makeConstraints { const in
            const.top.equalTo(TitleLabel.snp.bottom).offset(DeviceHeight * 0.05)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.8, height: DeviceHeight * 0.1))
            const.left.equalTo(TitleLabel.snp.left)
        }
        
        DescriptionLabel.verticalAlignment = .top
        DescriptionLabel.text = "다음날 누군가의 PUSH 메시지에\n내가 제보한 TMI가 전달될 수도 ?!\n혹시 모르니, 프로필 사진 멋지게 바꿔두기."
        DescriptionLabel.font = UIFont(name: "SpoqaHanSansNeo-Light", size: 15)
        DescriptionLabel.numberOfLines = 3
        
        DescriptionLabel.snp.makeConstraints { const in
            const.top.equalTo(SubTitleLabel.snp.bottom)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.8, height: DeviceHeight * 0.1))
            const.left.equalTo(TitleLabel.snp.left)
        }
        
        profileImgView.layer.cornerRadius = DeviceWidth * 0.125
        profileImgView.layer.borderWidth = 1
        profileImgView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        profileImgView.clipsToBounds = true
        profileImgView.layer.masksToBounds = true
        profileImgView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        profileImgView.image = UIImage(named: "JJANGU")
        
        profileImgView.snp.makeConstraints { const in
            const.top.equalTo(DescriptionLabel.snp.bottom).offset(DeviceHeight * 0.05)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.25, height: DeviceWidth * 0.25))
            const.centerX.equalTo(view.snp.centerX)
        }
        
        NameLabel.text = "장계장계장"
        NameLabel.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 35)
        NameLabel.textAlignment = .center
        
        
        NameLabel.snp.makeConstraints { const in
            const.top.equalTo(profileImgView.snp.bottom)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.8, height: DeviceHeight * 0.1))
            const.left.equalTo(TitleLabel.snp.left)
        }
        
        updateImgBtn.setImage(updateImg, for: .normal)
        updateImgBtn.snp.makeConstraints { const in
            const.top.equalTo(profileImgView.snp.bottom).offset(DeviceWidth * -0.075)
            const.left.equalTo(profileImgView.snp.right).offset(DeviceWidth * -0.075)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.1, height: DeviceWidth * 0.1))
        }
        
        BackBtn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.13)
        BackBtn.layer.cornerRadius = 20
        BackBtn.setTitle("이전으로", for: .normal)
        BackBtn.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.58), for: .normal)
        BackBtn.titleLabel?.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 20)
        
        BackBtn.snp.makeConstraints { const in
            const.leading.equalTo(TitleLabel.snp.leading)
            const.bottom.equalTo(view.snp.bottom).offset(DeviceHeight * -0.05)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.375, height: DeviceHeight * 0.06))
        }
        
        let tapBackBtnGesture = UITapGestureRecognizer(target: self, action: #selector (tapBackBtn))
        tapBackBtnGesture.numberOfTapsRequired = 1
        BackBtn.addGestureRecognizer(tapBackBtnGesture)
        
        ConfirmBtn.backgroundColor = .black
        ConfirmBtn.layer.cornerRadius = 20
        ConfirmBtn.setTitle("선택완료", for: .normal)
        ConfirmBtn.setTitleColor(UIColor(red: 255, green: 255, blue: 255, alpha: 1), for: .normal)
        ConfirmBtn.titleLabel?.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 20)
        
        ConfirmBtn.snp.makeConstraints { const in
            const.trailing.equalTo(SoonLabel.snp.trailing)
            const.bottom.equalTo(view.snp.bottom).offset(DeviceHeight * -0.05)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.375, height: DeviceHeight * 0.06))
        }
        
        let tapConfirmBtnGesture = UITapGestureRecognizer(target: self, action: #selector (tapConfirmBtn))
        tapConfirmBtnGesture.numberOfTapsRequired = 1
        ConfirmBtn.addGestureRecognizer(tapConfirmBtnGesture)
        
        let TakePhoto = UIAlertAction(title: "프로필 사진 촬영", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            else {
                self.present(self.ALERT_FailToTakePhoto, animated: true, completion: nil)
            }
        })
        
        let SelectPhoto = UIAlertAction(title: "앨범에서 선택", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true){
            }
        })
        
        let DeleteProfileImg = UIAlertAction(title: "프로필 사진 삭제", style: .destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            if self.profileImgView.image != nil {
                self.profileImgView.image = nil
            }
        })
        
        let CloselAction = UIAlertAction(title: "닫기", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        alert.addAction(TakePhoto)
        alert.addAction(SelectPhoto)
        alert.addAction(DeleteProfileImg)
        alert.addAction(CloselAction)
        
        let tapUpdateBtnGesture = UITapGestureRecognizer(target: self, action: #selector (tapUpdateBtn))
        
        tapUpdateBtnGesture.numberOfTapsRequired = 1
        updateImgBtn.addGestureRecognizer(tapUpdateBtnGesture)
        
    }
    @objc func tapUpdateBtn() {
        print("tapUpdateBtn")
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func pickImage(){
        self.present(self.imagePicker, animated: true)
    }
}

extension SettingProfileImageVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func tapConfirmBtn() {
        print("tapConfirmBtn")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "TMITabBarViewController") as! TMITabBarViewController
        
        self.show(nextVC, sender: nil)
    }
    
    @objc func tapBackBtn() {
        print("tapBackBtn")
        self.navigationController?.popViewController(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage? = nil // update 할 이미지
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage // 수정된 이미지가 있을 경우
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage // 원본 이미지가 있을 경우
        }
        
        self.profileImgView.image = newImage // 받아온 이미지를 update
        
        picker.dismiss(animated: true, completion: nil) // picker를 닫아줌
        
    }
}
