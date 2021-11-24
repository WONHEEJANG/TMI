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
//        TMIDetailContentView.roundCorners(cornerRadius: 40, maskedCorners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner])
        
        
        //============TMIDetailView============
        
        TMIDetailView.clipsToBounds = true

        TMIDetailView.layer.cornerRadius = 40

        TMIDetailView.layer.borderWidth = 1

        TMIDetailView.layer.borderColor = UIColor.black.cgColor
        
        
        //===============================
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ContentView", #function)
    }
    override func viewDidDisappear(_ animated: Bool) {
           super.viewDidDisappear(animated)
           print("ContentView", #function)
       }

}

