//
//  ViewController.swift
//  TMI
//
//  Created by NHDIC-BMT2 on 2021/11/08.
//

import UIKit
import Firebase
import FirebaseMessaging

class FeedViewController: UIViewController {

    var FeedToDetailTransition = TransitionController()
    
    let db = Database.database().reference()
    @IBOutlet weak var TMICollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //푸시 권한 요청
        requestNotificationPermission()
        
        db.child("firstData").observeSingleEvent(of: .value) { snapshot in
            print("snapshot : \(snapshot)")
            print("VIEWDIDLOAD")
        }
        
        
        //wine 키워드 구도
        Messaging.messaging().subscribe(toTopic: "정하늘") { error in
            if (error != nil) {
                        print("Unable to connect with FCM. \(error)")
                    } else {
                        print("Connected to FCM.")
                    }
        }
        
    }   
    
    //푸시권한
    func requestNotificationPermission(){
           UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow,Error in
               if didAllow {
                   print("Push: 권한 허용")
               } else {
                   print("Push: 권한 거부")
               }
           })
       }
    
}


extension FeedViewController: UICollectionViewDataSource {
    // 몇개 표시 할까?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    // 셀 어떻게 표시 할까?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TMICollectionViewCell", for: indexPath) as? TMICollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.TMIDescriptionLabel.text = TMIList[indexPath.row].description
        cell.TMIEmojiLabel.text = TMIList[indexPath.row].emoji
        
        return cell
    }
    
    // 헤더뷰 어떻게 표시할까?
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TMICollectionHeaderView", for: indexPath) as? TMICollectionHeaderView else {
                return UICollectionReusableView()
            }
            
            return header
        default:
            return UICollectionReusableView()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let width: CGFloat = collectionView.bounds.width - (20 * 2)
        let height: CGFloat = width

        print("width : \(width)")
        print("height : \(height)")
        return CGSize(width: width, height: height)
    }

}

extension FeedViewController: UICollectionViewDelegate {
    // 클릭했을때 어떻게 할까?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("tap => \(indexPath)")
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let contentVC = storyboard.instantiateViewController(withIdentifier: "TMIDetailViewController") as! TMIDetailViewController
        
        //=============================얘네가 데이터 넘기는거임=======================
        FeedToDetailTransition.indexPath = indexPath
        FeedToDetailTransition.superViewController = contentVC
        
        print("emoji :: \(TMIList[indexPath.row].emoji)")
      
        contentVC.modalPresentationStyle = .custom
        contentVC.transitioningDelegate = FeedToDetailTransition
        
        contentVC.modalPresentationCapturesStatusBarAppearance = true
        
        self.present(contentVC, animated: true, completion: nil)
        
    }
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    // 셀 사이즈 어떻게 할까?
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 20 - card(width) - 20
        let width: CGFloat = collectionView.bounds.width - (20 * 2)
        let height: CGFloat = width / 3
        return CGSize(width: width, height: height)
    }
}

extension UIView {
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
}

enum GlobalConstants {
    static var safeAreaLayoutTop: CGFloat = 0
    static let transitionDuration: CGFloat = 0.5
    static let cornerRadius: CGFloat = 15
}
