//
//  ViewController.swift
//  TMI
//
//  Created by NHDIC-BMT2 on 2021/11/08.
//

import UIKit
import Firebase

class WritingViewController: UIViewController, UITextFieldDelegate{
    
    
    var SendBtnToBottom_origin = CGFloat()
    let db = Database.database().reference()
    
    @IBOutlet weak var emojiTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var SendBtn: UIButton!
    @IBOutlet weak var SendBtnToBottomSafeArea: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SendBtnToBottom_origin = SendBtnToBottomSafeArea.constant
        
        setKeyboardObserver()
        
        emojiTextField.delegate = self
        
        let tapSendBtnGesture = UITapGestureRecognizer(target: self, action: #selector (tapSendBtn))
        
        tapSendBtnGesture.numberOfTapsRequired = 1
        SendBtn.addGestureRecognizer(tapSendBtnGesture)
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.emojiTextField.resignFirstResponder()
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

            self.emojiTextField.resignFirstResponder()
    
            return true
        }

    
    override func viewWillAppear(_ animated: Bool) {
        self.emojiTextField.becomeFirstResponder()
    }
}

extension WritingViewController {
    
    @objc func tapSendBtn() {
        print("tapSendBtn")
        let emoji = emojiTextField.text ?? "emptyEMOJI"
        let title = titleTextField.text ?? "emptyTITLE"
        let description = descriptionTextField.text ?? "emptyDescription"
        
        db.child("TMI").setValue(["emoji":emoji,"title":title,"description":description])
    }
    
    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(WritingViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(WritingViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
           if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                   let keyboardRectangle = keyboardFrame.cgRectValue
                   let keyboardHeight = keyboardRectangle.height
               UIView.animate(withDuration: 1) {
                   self.SendBtnToBottomSafeArea.constant = keyboardHeight
                   self.view.layoutIfNeeded()
               }
           }
        print("keyboardwillshow")
        print(SendBtnToBottom_origin)
        print(self.SendBtnToBottomSafeArea.constant)
       }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if SendBtnToBottom_origin != SendBtnToBottomSafeArea.constant {
                if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                        let keyboardRectangle = keyboardFrame.cgRectValue
                        let keyboardHeight = keyboardRectangle.height
                    
                    UIView.animate(withDuration: 1) {
                        self.SendBtnToBottomSafeArea.constant = 0
                        self.view.layoutIfNeeded()
                    }
                }
            }
        print("keyboardwillhide")
        print(SendBtnToBottom_origin)
        print(self.SendBtnToBottomSafeArea.constant)
        }
}
