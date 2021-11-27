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
    }
    func set_DetailContentView(){
        TMIDetailContentView.clipsToBounds = true
        TMIDetailContentView.layer.cornerRadius = 40
        TMIDetailContentView.layer.borderWidth = 2
        TMIDetailContentView.layer.borderColor = UIColor.black.cgColor
    }
    func set_TMIDetailViewEmojiLabel(){
        TMIDetailViewEmojiLabel.snp.makeConstraints{(const) in
            const.top.equalToSuperview().offset(50)
            const.leading.equalToSuperview().offset(35)
            const.width.equalTo(50) //추가 21.11.24
        }
        TMIDetailViewEmojiLabel.backgroundColor = .white
        TMIDetailViewEmojiLabel.clipsToBounds = true
        TMIDetailViewEmojiLabel.layer.cornerRadius = 10
        TMIDetailViewEmojiLabel.layer.borderWidth = 1
        TMIDetailViewEmojiLabel.layer.borderColor = UIColor.black.cgColor
        TMIDetailViewEmojiLabel.textAlignment = .center
    }
    func set_TMIDetailViewDescriptionLabel(){
        TMIDetailViewDescriptionLabel.snp.makeConstraints{(const) in
            const.top.equalTo(TMIDetailViewEmojiLabel.snp.bottom).offset(20)
            const.leading.equalTo(TMIDetailViewEmojiLabel.snp.leading)
            const.trailing.equalTo(TMIDetailContentView.snp.trailing).offset(-20) //추가 21.11.24
        }
        TMIDetailViewDescriptionLabel.lineBreakMode = .byWordWrapping
    }
}

