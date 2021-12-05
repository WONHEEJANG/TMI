//
//  ViewController.swift
//  TMI
//
//  Created by NHDIC-BMT2 on 2021/11/08.
//

import UIKit
import SnapKit

class SettingNameVC: UIViewController,UITextFieldDelegate {
    let DeviceHeight = UIScreen.main.bounds.height
    let DeviceWidth = UIScreen.main.bounds.width
    var isFirst : Bool = true
    
    var TitleLabel = UILabel()
    var SubTitleLabel = VerticalAlignLabel()
    var ConfirmBtn = UIButton(type: .system)
    //    @IBOutlet weak var textField: UITextField!
    var textField = UITextField()
    
    override func viewWillAppear(_ animated: Bool) {
        self.textField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(TitleLabel)
        self.view.addSubview(SubTitleLabel)
        self.view.addSubview(textField)
        self.view.addSubview(ConfirmBtn)
        
        //        TitleLabel.backgroundColor = .red
        //        SubTitleLabel.backgroundColor = .orange
        //        textField.backgroundColor = .orange
        
        TitleLabel.text = "🍞➕"
        TitleLabel.font = TitleLabel.font.withSize(40)
        
        TitleLabel.snp.makeConstraints { const in
            const.top.equalTo(view.snp.top).offset(DeviceHeight * 0.1)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.8, height: DeviceHeight * 0.05))
            const.left.equalTo(view.snp.left).offset(DeviceWidth * 0.1)
        }
        
        
        SubTitleLabel.verticalAlignment = .top
        SubTitleLabel.text = "안녕하세요!\n닉네임을 지어주세요."
        SubTitleLabel.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 22)
        SubTitleLabel.numberOfLines = 2
        
        SubTitleLabel.snp.makeConstraints { const in
            const.top.equalTo(TitleLabel.snp.bottom).offset(DeviceHeight * 0.05)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.8, height: DeviceHeight * 0.1))
            const.left.equalTo(TitleLabel.snp.left)
        }
        
        setKeyboardObserver()
        textField.delegate = self
        textField.textAlignment = .center
        
        textField.snp.makeConstraints { const in
            const.centerX.equalTo(view.snp.centerX)
            const.centerY.equalTo(view.snp.centerY).offset(DeviceHeight * -0.03)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.8, height: DeviceHeight * 0.1))
        }
        
        ConfirmBtn.backgroundColor = .black
        ConfirmBtn.layer.cornerRadius = 20
        ConfirmBtn.setTitle("확인", for: .normal)
        ConfirmBtn.setTitleColor(UIColor(red: 255, green: 255, blue: 255, alpha: 1), for: .normal)
        ConfirmBtn.titleLabel?.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 20)
        
        ConfirmBtn.snp.makeConstraints { const in
            const.centerX.equalTo(view.snp.centerX)
            const.bottom.equalTo(view.snp.bottom).offset(DeviceHeight * -0.05)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.8, height: DeviceHeight * 0.06))
        }
        
        let tapConfirmBtnGesture = UITapGestureRecognizer(target: self, action: #selector (tapConfirmBtn))
        tapConfirmBtnGesture.numberOfTapsRequired = 1
        ConfirmBtn.addGestureRecognizer(tapConfirmBtnGesture)
        
        
        
    }
}

extension SettingNameVC {
    @objc func tapConfirmBtn() {
        print("tapConfirmBtn")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "SettingCategoryVC") as! SettingCategoryVC
        
        self.show(nextVC, sender: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.resignFirstResponder()
    }
    
    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(SettingNameVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SettingNameVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            //            UIView.animate(withDuration: 1) {
            //                self.view.layoutIfNeeded()
            //            }
        }
        print("keyboardwillshow")
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            //            UIView.animate(withDuration: 1) {
            //                self.view.layoutIfNeeded()
            //            }
        }
        print("keyboardwillhide")
    }
}
