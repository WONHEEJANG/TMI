//
//  ViewController.swift
//  TMI
//
//  Created by NHDIC-BMT2 on 2021/11/08.
//

import UIKit
import SnapKit
import KakaoSDKUser

class SettingNameVC: UIViewController,UITextFieldDelegate {
    let DeviceHeight = UIScreen.main.bounds.height
    let DeviceWidth = UIScreen.main.bounds.width
    var isFirst : Bool = true
    
    var TitleLabel = UILabel()
    var SubTitleLabel = VerticalAlignLabel()
    var ConfirmBtn = UIButton(type: .system)
    
    var textField = UITextField()
    
    var loginUsr : User?
    
    override func viewWillAppear(_ animated: Bool) {
        self.textField.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SETTING_NAME_TO_CATEGORY" {
            if let vc = segue.destination as? SettingCategoryVC {
                vc.loginUsr = sender as? User
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SettingNameVC loginUsr : \(loginUsr?.id)")
        print("SettingNameVC loginUsr : \(loginUsr?.profileImg)")
        print("SettingNameVC loginUsr : \(loginUsr?.name)")
        
        self.view.addSubview(TitleLabel)
        self.view.addSubview(SubTitleLabel)
        self.view.addSubview(textField)
        self.view.addSubview(ConfirmBtn)
        
        //                TitleLabel.backgroundColor = .red
        //                SubTitleLabel.backgroundColor = .orange
        //                textField.backgroundColor = .orange
        
        TitleLabel.text = "πβ"
        TitleLabel.font = TitleLabel.font.withSize(25)
        
        TitleLabel.snp.makeConstraints { const in
            const.top.equalTo(view.snp.top).offset(DeviceHeight * 0.1)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.8, height: DeviceHeight * 0.05))
            const.left.equalTo(view.snp.left).offset(DeviceWidth * 0.1)
        }
        
        
        SubTitleLabel.verticalAlignment = .top
        SubTitleLabel.text = "μλνμΈμ!\nλλ€μμ μ§μ΄μ£ΌμΈμ."
        SubTitleLabel.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 22)
        SubTitleLabel.numberOfLines = 2
        
        SubTitleLabel.snp.makeConstraints { const in
            const.top.equalTo(TitleLabel.snp.bottom).offset(DeviceHeight * 0.05)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.8, height: DeviceHeight * 0.1))
            const.left.equalTo(TitleLabel.snp.left)
        }
        
        setKeyboardObserver()
        
        if loginUsr?.id.contains("KAKAO_") == true {
            textField.text = loginUsr?.name
        }
        
        textField.delegate = self
        textField.textAlignment = .center
        textField.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 30)
        
        textField.snp.makeConstraints { const in
            const.centerX.equalTo(view.snp.centerX)
            const.centerY.equalTo(view.snp.centerY).offset(DeviceHeight * -0.1)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.8, height: DeviceHeight * 0.1))
        }
        
        ConfirmBtn.backgroundColor = .black
        ConfirmBtn.layer.cornerRadius = 20
        ConfirmBtn.setTitle("νμΈ", for: .normal)
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
        
        print("ConfirmBtn.snp.bottom : \(ConfirmBtn.snp.bottom)")
        
    }
}

extension SettingNameVC {
    @objc func tapConfirmBtn() {
        print("tap_SettingNameVC_ConfirmBtn")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "SettingCategoryVC") as! SettingCategoryVC
        
        self.loginUsr?.name = self.textField.text ?? "NIL"
        print(self.loginUsr?.name)
        
        performSegue(withIdentifier: "SETTING_NAME_TO_CATEGORY", sender: self.loginUsr)
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
            UIView.animate(withDuration: 1) {
                self.ConfirmBtn.snp.remakeConstraints { const in
                    const.centerX.equalTo(self.view.snp.centerX)
                    const.bottom.equalTo(self.view.snp.bottom).offset(self.DeviceHeight * -0.05 - keyboardHeight)
                    const.size.equalTo(CGSize(width: self.DeviceWidth * 0.8, height: self.DeviceHeight * 0.06))
                }
                self.view.layoutIfNeeded()
            }
        }
        print("keyboardwillshow")
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            
            UIView.animate(withDuration: 1) {
                self.ConfirmBtn.snp.remakeConstraints { const in
                    const.centerX.equalTo(self.view.snp.centerX)
                    const.bottom.equalTo(self.view.snp.bottom).offset(self.DeviceHeight * -0.05)
                    const.size.equalTo(CGSize(width: self.DeviceWidth * 0.8, height: self.DeviceHeight * 0.06))
                }
                self.ConfirmBtn.layoutIfNeeded()
            }
        }
        print("keyboardwillhide")
    }
}
