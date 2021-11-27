//
//  ViewController.swift
//  TMI
//
//  Created by NHDIC-BMT2 on 2021/11/08.
//

import UIKit
import SnapKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import AuthenticationServices

class LoginViewController: UIViewController {
    
    @IBOutlet var LoginView: UIView!
    let DeviceHeight = UIScreen.main.bounds.height
    let DeviceWidth = UIScreen.main.bounds.width
    
    //    let appleButton = ASAuthorizationAppleIDButton()
    let LoginImgView = UIImageView(image: UIImage(named: "login-main.png"))
    
    let appleButton = UIButton(type: .custom)
    let kakaoButton = UIButton(type: .custom)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginImgView()
        setupAppleLoginView()
        setupKakaoLoiginView()
        
    }
    
    func PresentWhenLoginComplete(){
        let view = self.storyboard?.instantiateViewController(withIdentifier: "TMITabBarViewController")
//        view?.modalTransitionStyle = UIModalTransitionStyle.partialCurl
        view?.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(view!, animated: true, completion: nil)
    }
    
    func setupLoginImgView(){
        
        self.LoginView.addSubview(LoginImgView)
        LoginImgView.snp.makeConstraints{(const) in
            const.centerX.equalToSuperview()
            const.top.equalToSuperview().offset(DeviceHeight * 0.25)
            const.height.equalTo(DeviceHeight * 0.25)
            const.width.equalTo(DeviceHeight * 0.25 / 1.2)
        }
        
    }
    func setupAppleLoginView(){
        //        appleButton.cornerRadius = 15
        //        appleButton.addTarget(self, action: #selector(clickAppleLogin), for: .touchUpInside)
        appleButton.setImage(UIImage(named: "apple-login.png"), for: .normal)
        appleButton.addTarget(self, action: #selector(clickAppleLogin), for: .touchUpInside)
        self.LoginView.addSubview(kakaoButton)
        self.LoginView.addSubview(appleButton)
        appleButton.snp.makeConstraints{(const) in
            const.centerX.equalToSuperview()
            const.top.equalToSuperview().offset(DeviceHeight * 0.6)
            const.width.equalTo(DeviceWidth * 0.8)
            const.height.equalTo(DeviceWidth * 0.8 / 5.8 )
            const.leading.equalToSuperview().offset(DeviceWidth * 0.1)
            const.trailing.equalToSuperview().offset(DeviceWidth * -0.1)
        }
    }
    
    @objc func clickAppleLogin(_ sender: UITapGestureRecognizer) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    func setupKakaoLoiginView()
    {
        kakaoButton.setImage(UIImage(named: "kakao-login.png"), for: .normal)
        kakaoButton.addTarget(self, action: #selector(clickKakaoLogin(_:)), for: .touchUpInside)
        self.LoginView.addSubview(kakaoButton)
        kakaoButton.snp.makeConstraints{(const) in
            const.centerX.equalToSuperview()
            const.top.equalTo(appleButton.snp.bottom).offset(DeviceHeight * 0.05)
            const.width.equalTo(DeviceWidth * 0.8)
            const.height.equalTo(DeviceWidth * 0.8 / 5.8 )
            const.leading.equalToSuperview().offset(DeviceWidth * 0.1)
            const.trailing.equalToSuperview().offset(DeviceWidth * -0.1)
        }
    }
    
    @objc func clickKakaoLogin(_ sender:UITapGestureRecognizer){
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                _ = oauthToken
                let accessToken = oauthToken?.accessToken
                print("accessToken:\(accessToken)")
                self.PresentWhenLoginComplete()
            }
        }
        
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                _ = user
                print("user?.id:\(user?.id)")
                print("user?.kakaoAccount?.email:\(user?.kakaoAccount?.email)")
                print("user?.kakaoAccount?.ageRange:\(user?.kakaoAccount?.ageRange)")
                print("user?.kakaoAccount?.profile?.nickname:\(user?.kakaoAccount?.profile?.nickname)")
            }
        }
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate, ASWebAuthenticationPresentationContextProviding{
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    
    // 성공 후 동작
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        //         - 최초 로그인에만 이름과 이메일을 받을 수 있습니다.
        //
        //        - 두번째 로그인부터는 앱에서 Apple ID 사용 중단하기 전까지 ID 값만 리턴해줍니다.
        //
        //        - [설정 앱] - [Apple ID] - [암호 및 보안] - [내 Apple ID를 사용하는 앱] 에서 'Apple ID 사용 중단'
        
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let idToken = credential.identityToken!
            let tokeStr = String(data: idToken, encoding: .utf8)
            print("tokeStr : \(tokeStr)")
            
            guard let code = credential.authorizationCode else { return }
            let codeStr = String(data: code, encoding: .utf8)
            print("codeStr : \(codeStr)")
            
            let user = credential.user
            print("user : \(user)")
            print("credential.fullName : \((credential.fullName?.givenName ?? "") + (credential.fullName?.familyName ?? ""))")
            print("credential.email : \(credential.email)")
            
            self.PresentWhenLoginComplete()
        }
    }
    // 실패 후 동작
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("error")
    }
}
