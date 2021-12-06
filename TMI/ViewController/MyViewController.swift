//
//  ViewController.swift
//  TMI
//
//  Created by NHDIC-BMT2 on 2021/11/08.
//

import UIKit
import SnapKit

class MyViewController: UIViewController,UITextFieldDelegate {
    let DeviceHeight = UIScreen.main.bounds.height
    let DeviceWidth = UIScreen.main.bounds.width
    var SettingBtn = UIButton()
    var profileImgView = UIImageView()
    var NameLabel = UILabel()
    
    var underLine = UIView()
    var targetLine = UIView()
    
    var WritingTitle = UILabel()
    var NumOfWriting = UILabel()
    var WritingBtn = UIButton()
    
    var SavingTitle = UILabel()
    var NumOfSaving = UILabel()
    var SavingBtn = UIButton()
    
    var FollowerTitle = UILabel()
    var NumOfFollower = UILabel()
    var FollowerBtn = UIButton()
    
    var FollowingTitle = UILabel()
    var NumOfFollowing = UILabel()
    var FollowingBtn = UIButton()
    
    let updateImg = UIImage(named: "icon-plus")
    var updateImgBtn = UIButton()
    var alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let imagePicker = UIImagePickerController()
    let ALERT_FailToTakePhoto = UIAlertController(title: "Missing camera", message: "You can't take photo, there is no camera.", preferredStyle: UIAlertController.Style.alert)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker.allowsEditing = true // 수정 가능 여부
        self.imagePicker.delegate = self // picker delegate
        
        self.view.addSubview(SettingBtn)
        self.view.addSubview(profileImgView)
        self.view.addSubview(NameLabel)
        self.view.addSubview(updateImgBtn)
        
        self.view.addSubview(WritingTitle)
        self.view.addSubview(NumOfWriting)

        self.view.addSubview(SavingTitle)
        self.view.addSubview(NumOfSaving)

        self.view.addSubview(FollowerTitle)
        self.view.addSubview(NumOfFollower)

        self.view.addSubview(FollowingTitle)
        self.view.addSubview(NumOfFollowing)
        
        self.view.addSubview(WritingBtn)
        self.view.addSubview(SavingBtn)
        self.view.addSubview(FollowerBtn)
        self.view.addSubview(FollowingBtn)

        self.view.addSubview(underLine)
        self.view.addSubview(targetLine)
        
        //        TitleLabel.backgroundColor = .red
        //        SoonLabel.backgroundColor = .blue
        //        SubTitleLabel.backgroundColor = .orange
        //        DescriptionLabel.backgroundColor = .green
        //        updateImgBtn.backgroundColor = .darkGray
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.tabBarItem = nil
        
        SettingBtn.setImage(UIImage(named: "icon-setting"), for: .normal)
        
        SettingBtn.snp.makeConstraints { const in
            const.top.equalTo(view.snp.top).offset(DeviceHeight * 0.07)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.07, height: DeviceWidth * 0.07))
            const.trailing.equalTo(view.snp.trailing).offset(DeviceHeight * -0.03)
        }
        
        profileImgView.layer.cornerRadius = DeviceWidth * 0.125
        profileImgView.layer.borderWidth = 1
        profileImgView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        profileImgView.clipsToBounds = true
        profileImgView.layer.masksToBounds = true
        profileImgView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        profileImgView.image = UIImage(named: "JJANGU")
        
        profileImgView.snp.makeConstraints { const in
            const.top.equalTo(SettingBtn.snp.bottom).offset(DeviceHeight * 0.02)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.25, height: DeviceWidth * 0.25))
            const.centerX.equalTo(view.snp.centerX)
        }
        
        NameLabel.text = "장계장계장"
        NameLabel.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 35)
        NameLabel.textAlignment = .center
        
        
        NameLabel.snp.makeConstraints { const in
            const.top.equalTo(profileImgView.snp.bottom)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.8, height: DeviceHeight * 0.1))
            const.centerX.equalTo(profileImgView.snp.centerX)
        }
        
        updateImgBtn.setImage(updateImg, for: .normal)
        updateImgBtn.snp.makeConstraints { const in
            const.top.equalTo(profileImgView.snp.bottom).offset(DeviceWidth * -0.075)
            const.left.equalTo(profileImgView.snp.right).offset(DeviceWidth * -0.075)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.1, height: DeviceWidth * 0.1))
        }
        
        
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
    
        NumOfWriting.text = "1"
        NumOfWriting.textAlignment = .center
        NumOfWriting.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 15)
        
        WritingTitle.text = "집필함"
        WritingTitle.textAlignment = .center
        WritingTitle.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 15)
        
        
        NumOfSaving.text = "37"
        NumOfSaving.textAlignment = .center
        NumOfSaving.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 15)
        
        SavingTitle.text = "보관함"
        SavingTitle.textAlignment = .center
        SavingTitle.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 15)
        
        NumOfFollower.text = "3"
        NumOfFollower.textAlignment = .center
        NumOfFollower.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 15)
        
        FollowerTitle.text = "팔로워"
        FollowerTitle.textAlignment = .center
        FollowerTitle.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 15)
        
        NumOfFollowing.text = "15"
        NumOfFollowing.textAlignment = .center
        NumOfFollowing.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 15)
        
        FollowingTitle.text = "팔로잉"
        FollowingTitle.textAlignment = .center
        FollowingTitle.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 15)
        
        underLine.backgroundColor = .black
        targetLine.backgroundColor = .black
        
        underLine.alpha = 0.1
        targetLine.alpha = 1
        
        let Height = 0.03
        
        NumOfWriting.snp.makeConstraints { const in
            const.top.equalTo(NameLabel.snp.bottom)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.25, height: DeviceHeight * Height))
            const.leading.equalTo(view.snp.leading)
        }
        
        WritingTitle.snp.makeConstraints { const in
            const.top.equalTo(NumOfWriting.snp.bottom)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.25, height: DeviceHeight * Height))
            const.leading.equalTo(view.snp.leading)
        }
        
        NumOfSaving.snp.makeConstraints { const in
            const.top.equalTo(NameLabel.snp.bottom)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.25, height: DeviceHeight * Height))
            const.leading.equalTo(NumOfWriting.snp.trailing)
        }
        SavingTitle.snp.makeConstraints { const in
            const.top.equalTo(NumOfSaving.snp.bottom)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.25, height: DeviceHeight * Height))
            const.leading.equalTo(WritingTitle.snp.trailing)
        }
        
        NumOfFollower.snp.makeConstraints { const in
            const.top.equalTo(NameLabel.snp.bottom)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.25, height: DeviceHeight * Height))
            const.leading.equalTo(NumOfSaving.snp.trailing)
        }
        
        FollowerTitle.snp.makeConstraints { const in
            const.top.equalTo(NumOfFollower.snp.bottom)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.25, height: DeviceHeight * Height))
            const.leading.equalTo(SavingTitle.snp.trailing)
        }
        
        NumOfFollowing.snp.makeConstraints { const in
            const.top.equalTo(NameLabel.snp.bottom)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.25, height: DeviceHeight * Height))
            const.trailing.equalTo(view.snp.trailing)
        }
        
        FollowingTitle.snp.makeConstraints { const in
            const.top.equalTo(NumOfFollowing.snp.bottom)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.25, height: DeviceHeight * Height))
            const.trailing.equalTo(view.snp.trailing)
        }

        underLine.snp.makeConstraints { const in
            const.top.equalTo(WritingTitle.snp.bottom).offset(DeviceHeight * 0.01)
            const.size.equalTo(CGSize(width: DeviceWidth, height: 2))
            const.leading.equalTo(view.snp.leading)
            const.trailing.equalTo(view.snp.trailing)
        }

        targetLine.snp.makeConstraints { const in
            const.top.equalTo(FollowingTitle.snp.bottom).offset(DeviceHeight * 0.01)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.25, height: 2))
            const.leading.equalTo(view.snp.leading)
        }
        
        WritingBtn.snp.makeConstraints { const in
            const.top.equalTo(NumOfWriting.snp.top)
            const.leading.equalTo(NumOfWriting.snp.leading)
            const.trailing.equalTo(NumOfWriting.snp.trailing)
            const.bottom.equalTo(WritingTitle.snp.bottom)
        }
        SavingBtn.snp.makeConstraints { const in
            const.top.equalTo(NumOfSaving.snp.top)
            const.leading.equalTo(NumOfSaving.snp.leading)
            const.trailing.equalTo(NumOfSaving.snp.trailing)
            const.bottom.equalTo(SavingTitle.snp.bottom)
        }
        
        FollowerBtn.snp.makeConstraints { const in
            const.top.equalTo(NumOfFollower.snp.top)
            const.leading.equalTo(NumOfFollower.snp.leading)
            const.trailing.equalTo(NumOfFollower.snp.trailing)
            const.bottom.equalTo(FollowerTitle.snp.bottom)
        }
        
        FollowingBtn.snp.makeConstraints { const in
            const.top.equalTo(NumOfFollowing.snp.top)
            const.leading.equalTo(NumOfFollowing.snp.leading)
            const.trailing.equalTo(NumOfFollowing.snp.trailing)
            const.bottom.equalTo(FollowingTitle.snp.bottom)
        }
        
        let tapWritingBtnGesture = UITapGestureRecognizer(target: self, action: #selector (tapWritingBtn))
        tapWritingBtnGesture.numberOfTapsRequired = 1
        WritingBtn.addGestureRecognizer(tapWritingBtnGesture)
        
        let tapSavingBtnGesture = UITapGestureRecognizer(target: self, action: #selector (tapSavingBtn))
        tapSavingBtnGesture.numberOfTapsRequired = 1
        SavingBtn.addGestureRecognizer(tapSavingBtnGesture)
        
        let tapFollowerBtnGesture = UITapGestureRecognizer(target: self, action: #selector (tapFollowerBtn))
        tapFollowerBtnGesture.numberOfTapsRequired = 1
        FollowerBtn.addGestureRecognizer(tapFollowerBtnGesture)
        
        let tapFollowingBtnGesture = UITapGestureRecognizer(target: self, action: #selector (tapFollowingBtn))
        tapFollowingBtnGesture.numberOfTapsRequired = 1
        FollowingBtn.addGestureRecognizer(tapFollowingBtnGesture)
        
        
        
    }
    @objc func tapWritingBtn() {
        print("tapWritingBtn")
    
        UIView.animate(withDuration: 0.5) {
            self.targetLine.snp.remakeConstraints { const in
                const.top.equalTo(self.FollowingTitle.snp.bottom).offset(self.DeviceHeight * 0.01)
                const.size.equalTo(CGSize(width: self.DeviceWidth * 0.25, height: 2))
                const.leading.equalTo(self.view.snp.leading)
            }
            self.view.layoutIfNeeded()
        }
    }
    @objc func tapSavingBtn() {
        print("tapSavingBtn")
        UIView.animate(withDuration: 0.5) {
            self.targetLine.snp.remakeConstraints { const in
                const.top.equalTo(self.FollowingTitle.snp.bottom).offset(self.DeviceHeight * 0.01)
                const.size.equalTo(CGSize(width: self.DeviceWidth * 0.25, height: 2))
                const.leading.equalTo(self.view.snp.leading).offset(self.DeviceWidth * 0.25)
            }
            self.view.layoutIfNeeded()
        }
    }
    @objc func tapFollowerBtn() {
        print("tapFollowerBtn")
        UIView.animate(withDuration: 0.5) {
            self.targetLine.snp.remakeConstraints { const in
                const.top.equalTo(self.FollowingTitle.snp.bottom).offset(self.DeviceHeight * 0.01)
                const.size.equalTo(CGSize(width: self.DeviceWidth * 0.25, height: 2))
                const.leading.equalTo(self.view.snp.leading).offset(self.DeviceWidth * 0.5)
            }
            self.view.layoutIfNeeded()
        }
    }
    @objc func tapFollowingBtn() {
        print("tapFollowingBtn")
        UIView.animate(withDuration: 0.5) {
            self.targetLine.snp.remakeConstraints { const in
                const.top.equalTo(self.FollowingTitle.snp.bottom).offset(self.DeviceHeight * 0.01)
                const.size.equalTo(CGSize(width: self.DeviceWidth * 0.25, height: 2))
                const.leading.equalTo(self.view.snp.leading).offset(self.DeviceWidth * 0.75)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func tapUpdateBtn() {
        print("tapUpdateBtn")
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func pickImage(){
        self.present(self.imagePicker, animated: true)
    }
}

extension MyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
