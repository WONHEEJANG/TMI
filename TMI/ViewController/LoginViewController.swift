//
//  ViewController.swift
//  TMI
//
//  Created by NHDIC-BMT2 on 2021/11/08.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class LoginViewController: UIViewController {

    
    @IBOutlet weak var KAKAO_LOGIN: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")

                    //do something
                    _ = oauthToken
                }
            }
        
    }


}

