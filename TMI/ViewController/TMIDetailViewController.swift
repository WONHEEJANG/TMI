//
//  ViewController.swift
//  TMI
//
//  Created by NHDIC-BMT2 on 2021/11/08.
//

import UIKit

class TMIDetailViewController: UIViewController {
    @IBOutlet weak var TMIDetailView: UIView!
    @IBOutlet weak var TMIDetailContentView: UIView!
    @IBOutlet weak var TMIDetailViewEmojiLabel: UILabel!
    @IBOutlet weak var TMIDetailViewDescriptionLabel: UILabel!
    @IBOutlet weak var closebutton: UIButton!
    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var ProfileImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ContentView", #function)
        set_DetailView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ContentView", #function)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ContentView", #function)
    }
    func set_DetailView(){
        set_DetailContentView()
        set_TMIDetailViewEmojiLabel()
        set_TMIDetailViewDescriptionLabel()
        set_closeButton()
    }
    func set_closeButton(){
        closebutton.snp.makeConstraints{(const) in
            const.top.equalToSuperview().offset(10)
            const.trailing.equalToSuperview().offset(-10)
        }
        closebutton.tintColor = .black
        
        let tapCloseBtnGesture = UITapGestureRecognizer(target: self, action: #selector (handleTap))
        
        tapCloseBtnGesture.numberOfTapsRequired = 1
        closebutton.addGestureRecognizer(tapCloseBtnGesture)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer)
    {
        print("tap")
        self.dismiss(animated: true, completion: nil)
    }
    
    func set_DetailContentView(){
        TMIDetailContentView.clipsToBounds = true
        TMIDetailContentView.layer.cornerRadius = 20
        TMIDetailContentView.layer.borderWidth = 1
        TMIDetailContentView.layer.borderColor = UIColor.black.cgColor
    }
    func set_TMIDetailViewEmojiLabel(){

//        TMIDetailViewEmojiLabel.backgroundColor = .white
        TMIDetailViewEmojiLabel.clipsToBounds = true
        TMIDetailViewEmojiLabel.layer.cornerRadius = 10
//        TMIDetailViewEmojiLabel.layer.borderWidth = 1
//        TMIDetailViewEmojiLabel.layer.borderColor = UIColor.black.cgColor
        TMIDetailViewEmojiLabel.textAlignment = .center
        TMIDetailViewEmojiLabel.font = TMIDetailViewEmojiLabel.font.withSize(30)
    }
    func set_TMIDetailViewDescriptionLabel(){
//        TMIDetailViewDescriptionLabel.snp.makeConstraints{(const) in
//            const.top.equalTo(TMIDetailViewEmojiLabel.snp.bottom).offset(20)
//            const.leading.equalTo(TMIDetailViewEmojiLabel.snp.leading)
//            const.trailing.equalTo(TMIDetailContentView.snp.trailing).offset(-20) //추가 21.11.24
//        }
        TMIDetailViewDescriptionLabel.lineBreakMode = .byWordWrapping
    }
}

