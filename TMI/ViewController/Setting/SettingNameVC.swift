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
    var SubTitleLabel = UILabel()
    var textField = UITextField()
    
    override func viewWillAppear(_ animated: Bool) {
        self.textField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(TitleLabel)
        self.view.addSubview(SubTitleLabel)
        self.view.addSubview(textField)
        
        TitleLabel.backgroundColor = .red
        TitleLabel.text = "🍞➕"
        TitleLabel.font = TitleLabel.font.withSize(30)
        
        TitleLabel.snp.makeConstraints { const in
            const.top.equalTo(view.snp.top).offset(DeviceHeight * 0.1)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.8, height: DeviceHeight * 0.03))
            const.left.equalTo(view.snp.left).offset(DeviceWidth * 0.1)
        }
        
        SubTitleLabel.backgroundColor = .orange
        SubTitleLabel.text = "안녕하세요!\n닉네임을 지어주세요."
        SubTitleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        SubTitleLabel.numberOfLines = 2
        
        SubTitleLabel.snp.makeConstraints { const in
            const.top.equalTo(TitleLabel.snp.bottom).offset(DeviceHeight * 0.03)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.8, height: DeviceHeight * 0.1))
            const.left.equalTo(TitleLabel.snp.left)
        }
        
        setKeyboardObserver()
        textField.delegate = self
        textField.backgroundColor = .orange
        textField.textAlignment = .center
        
        textField.snp.makeConstraints { const in
            const.centerX.equalTo(view.snp.centerX)
            const.centerY.equalTo(view.snp.centerY)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.8, height: DeviceHeight * 0.1))
        }
        
        
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.resignFirstResponder()
    }
}

extension SettingNameVC {
    
    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(SettingNameVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SettingNameVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            UIView.animate(withDuration: 1) {
                self.view.layoutIfNeeded()
            }
        }
        print("keyboardwillshow")
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            UIView.animate(withDuration: 1) {
                self.view.layoutIfNeeded()
            }
        }
        print("keyboardwillhide")
    }
}
