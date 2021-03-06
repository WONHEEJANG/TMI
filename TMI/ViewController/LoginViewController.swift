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
import Alamofire


class LoginViewController: UIViewController {
    
    @IBOutlet var LoginView: UIView!
    let DeviceHeight = UIScreen.main.bounds.height
    let DeviceWidth = UIScreen.main.bounds.width
    
    let LoginImgView = UIImageView(image: UIImage(named: "login-main.png"))
    let appleButton = UIButton(type: .custom)
    let kakaoButton = UIButton(type: .custom)
    var isLogin : Bool = false
    var loginUsr = User()
    //    let appleButton = ASAuthorizationAppleIDButton()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            print("LoginView_DidLoad")
        
        
        
        if(!isLogin){
            setupLoginImgView()
            setupAppleLoginView()
            setupKakaoLoiginView()
        }
        else{
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LOGINtoSETTING" {
            if let target = segue.destination as? SettingNaviController, let vc = target.topViewController as? SettingNameVC {
                //                vc.loginUsr = sender as? String
                vc.loginUsr = sender as? User
            }
        }
    }
    
    func PresentWhenLoginComplete(){
        print("self.loginUsr : \(self.loginUsr)")
        self.performSegue(withIdentifier: "LOGINtoSETTING", sender: self.loginUsr)
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
        
        print("request.requestedScopes : \(request.requestedScopes)")
        
        let usr = User()
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
    
    
    func getDataFromKaKaoLogin(accessToken : String, completionHandler : @escaping (UserResponse)->Void) {
        
        var data : UserResponse!
        
        let url = "https://kapi.kakao.com/v2/user/me"
        
        let headers : HTTPHeaders = [ "Authorization" : "Bearer \(accessToken)"]
        
        
        AF.request(url,headers: headers) //???????????? ????????? ?????? ????????????
            .validate()
            .responseDecodable(of: UserResponse.self) { response in
                
                switch response.result {
                case .success(let response):
                    
                    print("DEBUG>> Success \(response) ")
                    
//                    let userItemRef = self.db.child("userDB").child("kakao_\(response.id)") // ????????? ????????? ????????? DB??? ??????
//                    let values: [String: Any] = ["login":"kakao", "kakao_id": response.id, "last_connected_at": response.connected_at, "kakao_nickname": response.properties.nickname, "kakao_profile_imge":response.properties.profile_image,"kakao_thumbnail_image":response.properties.thumbnail_image ]
//                    userItemRef.setValue(values)
                    
                    data = response
                    
                case .failure(let error):
                    print("DEBUG>> Error : \(error.localizedDescription)")
                }
                completionHandler(data)
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
                
                
                self.getDataFromKaKaoLogin(accessToken: accessToken!){ data in
                    self.loginUsr.id = "KAKAO_\(data.id)"
                    self.loginUsr.name = data.properties.nickname
                    self.loginUsr.profileImg = data.properties.profile_image
                    self.PresentWhenLoginComplete()
                }
            }
        }
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate, ASWebAuthenticationPresentationContextProviding{
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    
    // ?????? ??? ??????
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        //         - ?????? ??????????????? ????????? ???????????? ?????? ??? ????????????.
        //
        //        - ????????? ?????????????????? ????????? Apple ID ?????? ???????????? ????????? ID ?????? ??????????????????.
        //
        //        - [?????? ???] - [Apple ID] - [?????? ??? ??????] - [??? Apple ID??? ???????????? ???] ?????? 'Apple ID ?????? ??????'
        
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
    // ?????? ??? ??????
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("error")
    }
}
