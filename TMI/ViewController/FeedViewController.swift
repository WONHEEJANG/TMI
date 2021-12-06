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
        
        cell.TMIView.backgroundColor = cell.TMIEmojiLabel.toImage?.averageColor
        print("TMIEmojiLabel.text:\(cell.TMIEmojiLabel.text)")
        print("TMIView.backgroundColor:\(cell.TMIView.backgroundColor)")
        
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
        return CGSize(width: width, height: height * 1.1)
    }
    
}

extension FeedViewController: UICollectionViewDelegate {
    // 클릭했을때 어떻게 할까?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("tap => \(indexPath)")
        
        let cell = collectionView.cellForItem(at: indexPath) as! TMICollectionViewCell
        print(cell.frame)
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let contentVC = storyboard.instantiateViewController(withIdentifier: "TMIDetailViewController") as! TMIDetailViewController
        let TmiViewSize = cell.TMIView.frame.size
        //=============================얘네가 데이터 넘기는거임=======================
        
        //처음 Cell의 Frame을 기억해놨다가 나중에 Dismiss할 때 쓸 것임
        var currentCellFrame = cell.superview!.convert(cell.frame, to: nil)
        
        currentCellFrame.size.width = TmiViewSize.width
        currentCellFrame.size.height = TmiViewSize.height
        currentCellFrame.origin.x = 20
        
        
        print("UICollectionViewDelegate")
        print("cell.superview.frame : \(cell.superview!.frame)")
        print("cell.frame : \(cell.frame)")
        print("cell.TMIView.frame : \(cell.TMIView.frame)")
        print("currentCellFrame : \(currentCellFrame)")
        
        
        
        FeedToDetailTransition.targetCellFrame = currentCellFrame
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
    static let cornerRadius: CGFloat = 20
}


extension UILabel {
    var toImage :UIImage?{
        UIGraphicsBeginImageContext(self.frame.size)
        print("self.frame.size:\(self.frame.size)")
        print("self.frame.minX:\(self.frame.minX)")
        print("self.frame.minY:\(self.frame.minY)")
        if let currentContext = UIGraphicsGetCurrentContext() {
            self.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }
    
}

extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else {
            return nil
        }
        
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        
        guard
            let filter = CIFilter(
                name: "CIAreaAverage",
                parameters: [
                    kCIInputImageKey: inputImage,
                    kCIInputExtentKey: extentVector
                ]
            ),
            let outputImage = filter.outputImage else {
            return nil
        }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(
            outputImage,
            toBitmap: &bitmap,
            rowBytes: 4,
            bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
            format: .RGBA8,
            colorSpace: nil
        )
        print("origin_bitmap:\(bitmap)")
        
        //        for index in 0...2{
        //            bitmap[index] += UInt8(CGFloat(255 - bitmap[index]) * 0.7)
        //        }
        
        let bitmapAvg = UInt8((CGFloat(bitmap[0])/255 + CGFloat(bitmap[1])/255 + CGFloat(bitmap[2])/255) / 3 * 255)
        for index in 0...2{
            if bitmap[index] > bitmapAvg {
                bitmap[index] = 255
            }
        }
        
        print("bitmapAvg:\(bitmapAvg)")
        print("bitmap:\(bitmap)")
        
        let ratio:CGFloat = 0.98
        
        return UIColor(
            red: CGFloat(bitmap[0]) / 255 * ratio,
            green: CGFloat(bitmap[1]) / 255 * ratio,
            blue: CGFloat(bitmap[2]) / 255 * ratio,
            alpha: CGFloat(bitmap[3]) / 255 * ratio
        )
    }
}

//N넘으면 255로 극대화 시키자
