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

    let db = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        requestNotificationPermission()
        db.child("firstData").observeSingleEvent(of: .value) { snapshot in
            print("snapshot : \(snapshot)")
            print("VIEWDIDLOAD")
            
            Messaging.messaging().subscribe(toTopic: "wine") { error in
                if (error != nil) {
                            print("Unable to connect with FCM. \(error)")
                        } else {
                            print("Connected to FCM.")
                        }
            }
        }
    }
    
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
        
//        let item = trackManager.track(at: indexPath.item)
//        cell.updateUI(item: item)
        return cell
    }
    
    // 헤더뷰 어떻게 표시할까?
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
//            guard let item = trackManager.todaysTrack else {
//                return UICollectionReusableView()
//            }
            
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TMICollectionHeaderView", for: indexPath) as? TMICollectionHeaderView else {
                return UICollectionReusableView()
            }
            
//            header.update(with: item)
//            header.tapHandler = { item in
//                let playerStoryboard = UIStoryboard.init(name: "Player", bundle: nil)
//                guard let playerVC = playerStoryboard.instantiateViewController(identifier: "PlayerViewController") as? PlayerViewController else { return }
//                playerVC.simplePlayer.replaceCurrentItem(with: item)
//                self.present(playerVC, animated: true, completion: nil)
//            }
            
            return header
        default:
            return UICollectionReusableView()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width: CGFloat = collectionView.bounds.width - (20 * 2)
        let height: CGFloat = width / 2
        return CGSize(width: width, height: height)
    }

}

//extension HomeViewController: UICollectionViewDelegate {
//    // 클릭했을때 어떻게 할까?
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let playerStoryboard = UIStoryboard.init(name: "Player", bundle: nil)
//        guard let playerVC = playerStoryboard.instantiateViewController(identifier: "PlayerViewController") as? PlayerViewController else { return }
//        let item = trackManager.tracks[indexPath.item]
//        playerVC.simplePlayer.replaceCurrentItem(with: item)
//        present(playerVC, animated: true, completion: nil)
//    }
//}

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    // 셀 사이즈 어떻게 할까?
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 20 - card(width) - 20 - card(width) - 20
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
