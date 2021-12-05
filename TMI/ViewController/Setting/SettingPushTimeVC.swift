//
//  ViewController.swift
//  TMI
//
//  Created by NHDIC-BMT2 on 2021/11/08.
//

import UIKit
import SnapKit

class SettingPushTimeVC: UIViewController,UITextFieldDelegate{
    
    let DeviceHeight = UIScreen.main.bounds.height
    let DeviceWidth = UIScreen.main.bounds.width
    var isFirst : Bool = true
    
    
    var TitleLabel = UILabel()
    var SubTitleLabel = VerticalAlignLabel()
    var AddingText = UILabel()
    
    var TimePickerView = UIPickerView()
    var TimeSeperateMark = UILabel()
    
    var HourIndicatorView = UIView()
    var MinuteIndicatorView = UIView()
    
    var ConfirmBtn = UIButton(type: .system)
    var BackBtn = UIButton(type: .system)
    
    let Hours = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"]
    let Minutes = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hours : \(Hours)")
        print("Minutes : \(Minutes)")
        
        
        self.view.addSubview(TitleLabel)
        self.view.addSubview(SubTitleLabel)
        self.view.addSubview(AddingText)
        self.view.addSubview(TimePickerView)
        self.view.addSubview(TimeSeperateMark)
        self.view.addSubview(ConfirmBtn)
        self.view.addSubview(BackBtn)
        
        TimePickerView.addSubview(HourIndicatorView)
        TimePickerView.addSubview(MinuteIndicatorView)
        
//        TitleLabel.backgroundColor = .red
//        SubTitleLabel.backgroundColor = .orange
        
        
        TitleLabel.text = "🍞➕🧀➕🍅"
        TitleLabel.font = TitleLabel.font.withSize(40)
        
        TitleLabel.snp.makeConstraints { const in
            const.top.equalTo(view.snp.top).offset(DeviceHeight * 0.1)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.8, height: DeviceHeight * 0.05))
            const.left.equalTo(view.snp.left).offset(DeviceWidth * 0.1)
        }
        
        SubTitleLabel.verticalAlignment = .top
        SubTitleLabel.text = "골라주신 주제의 TMI를 \n매일 하나씩 보내드릴게요! \n몇시에 PUSH를 받을까요?"
        SubTitleLabel.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 22)
        SubTitleLabel.numberOfLines = 3
        
        
        SubTitleLabel.snp.makeConstraints { const in
            const.top.equalTo(TitleLabel.snp.bottom).offset(DeviceHeight * 0.05)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.8, height: DeviceHeight * 0.15))
            const.left.equalTo(TitleLabel.snp.left)
        }
        
        AddingText.text = "언제든 마이>설정에서 변경 가능해요."
        AddingText.font = AddingText.font.withSize(15)
        
        AddingText.snp.makeConstraints { const in
            const.top.equalTo(SubTitleLabel.snp.bottom)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.8, height: DeviceHeight * 0.05))
            const.left.equalTo(SubTitleLabel.snp.left)
        }
        
        TimePickerView.delegate = self
        TimePickerView.dataSource = self
    
        TimePickerView.snp.makeConstraints { const in
            const.bottom.equalTo(view.snp.bottom).offset(DeviceHeight * -0.15)
            const.size.equalTo(CGSize(width: DeviceWidth, height: DeviceHeight * 0.4))
            const.left.equalTo(view.snp.left)
            const.right.equalTo(view.snp.right)
        }
        
        TimeSeperateMark.text = ":"
        TimeSeperateMark.snp.makeConstraints { const in
            const.centerX.equalTo(TimePickerView.snp.centerX)
            const.centerY.equalTo(TimePickerView.snp.centerY)
        }
        HourIndicatorView.backgroundColor = .black
        HourIndicatorView.alpha = 0.1
        HourIndicatorView.layer.cornerRadius = 10
        
        HourIndicatorView.snp.makeConstraints { const in
            const.centerY.equalTo(TimePickerView.snp.centerY)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.4, height: DeviceHeight * 0.05))
            const.left.equalTo(TimePickerView.snp.left).offset(DeviceWidth * 0.05)
        }
        
        MinuteIndicatorView.backgroundColor = .black
        MinuteIndicatorView.alpha = 0.1
        MinuteIndicatorView.layer.cornerRadius = 10
        
        MinuteIndicatorView.snp.makeConstraints { const in
            const.centerY.equalTo(TimePickerView.snp.centerY)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.4, height: DeviceHeight * 0.05))
            const.right.equalTo(TimePickerView.snp.right).offset(DeviceWidth * -0.05)
        }
        
        BackBtn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.13)
        BackBtn.layer.cornerRadius = 20
        BackBtn.setTitle("이전으로", for: .normal)
        BackBtn.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.58), for: .normal)
        BackBtn.titleLabel?.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 20)
        
        BackBtn.snp.makeConstraints { const in
            const.leading.equalTo(TitleLabel.snp.leading)
            const.bottom.equalTo(view.snp.bottom).offset(DeviceHeight * -0.05)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.375, height: DeviceHeight * 0.06))
        }
        
        let tapBackBtnGesture = UITapGestureRecognizer(target: self, action: #selector (tapBackBtn))
        tapBackBtnGesture.numberOfTapsRequired = 1
        BackBtn.addGestureRecognizer(tapBackBtnGesture)
        
        ConfirmBtn.backgroundColor = .black
        ConfirmBtn.layer.cornerRadius = 20
        ConfirmBtn.setTitle("선택완료", for: .normal)
        ConfirmBtn.setTitleColor(UIColor(red: 255, green: 255, blue: 255, alpha: 1), for: .normal)
        ConfirmBtn.titleLabel?.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 20)
        
        ConfirmBtn.snp.makeConstraints { const in
            const.trailing.equalTo(TitleLabel.snp.trailing)
            const.bottom.equalTo(view.snp.bottom).offset(DeviceHeight * -0.05)
            const.size.equalTo(CGSize(width: DeviceWidth * 0.375, height: DeviceHeight * 0.06))
        }
        
        let tapConfirmBtnGesture = UITapGestureRecognizer(target: self, action: #selector (tapConfirmBtn))
        tapConfirmBtnGesture.numberOfTapsRequired = 1
        ConfirmBtn.addGestureRecognizer(tapConfirmBtnGesture)
    }
}

extension SettingPushTimeVC: UIPickerViewDataSource,UIPickerViewDelegate {
    @objc func tapConfirmBtn() {
        print("tapConfirmBtn")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "SettingProfileImageVC") as! SettingProfileImageVC
        
        self.show(nextVC, sender: nil)
    }
    
    @objc func tapBackBtn() {
        print("tapBackBtn")
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return Hours.count
        case 1:
            return Minutes.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return Hours[row]
        case 1:
            return Minutes[row]
        default:
            return "DEFAULT"
        }
    }
    override func viewDidLayoutSubviews() {
        TimePickerView.subviews[3].isHidden = true
    }
}
