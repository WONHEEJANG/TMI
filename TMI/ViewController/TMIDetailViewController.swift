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
    @IBOutlet weak var TMIDetailCardView: UIView!
    @IBOutlet weak var AddingView: UIView!
    @IBOutlet weak var AddingTextView: UITextView!
    
    
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
        print("DetailView CloseBtn TAP \u{1F603}")
        
        
        self.dismiss(animated: true, completion: nil)
    }
    func set_DetailContentView(){
        TMIDetailContentView.clipsToBounds = true
        TMIDetailContentView.layer.cornerRadius = 20
        TMIDetailContentView.layer.borderWidth = 1
        TMIDetailContentView.layer.borderColor = UIColor.black.cgColor
    }
    func set_TMIDetailViewEmojiLabel(){

        TMIDetailViewEmojiLabel.clipsToBounds = true
        TMIDetailViewEmojiLabel.layer.cornerRadius = 10
        TMIDetailViewEmojiLabel.textAlignment = .center
        TMIDetailViewEmojiLabel.font = TMIDetailViewEmojiLabel.font.withSize(30)
    }
    func set_TMIDetailViewDescriptionLabel(){
        TMIDetailViewDescriptionLabel.backgroundColor = .none
        TMIDetailViewDescriptionLabel.lineBreakMode = .byWordWrapping
    }
}

