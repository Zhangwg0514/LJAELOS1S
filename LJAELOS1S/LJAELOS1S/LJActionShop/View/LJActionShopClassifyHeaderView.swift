//
//  LJActionShopClassifyHeaderView.swift
//  LJAELOS1S
//
//  Created by 章卫国 on 2018/1/17.
//  Copyright © 2018年 章卫国. All rights reserved.
//

import UIKit

protocol LJActionShopClassifyHeaderViewDelegate: NSObjectProtocol {
    func LJActionShopClassifyHeaderViewBtnClick(button: UIButton)
}

class LJActionShopClassifyHeaderView: UICollectionReusableView {
    
    weak var delegate: LJActionShopClassifyHeaderViewDelegate?
    
    var newBtn: UIButton!
    var hotBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    func initUI() {
        newBtn = UIButton(type: .custom)
        newBtn.frame = CGRect(x: 15.0 * PW, y: 4 * PH, width: 78 * PW, height: 37.0 * PH)
        newBtn.setBackgroundImage(UIImage(named: "newest_button_press"), for: .selected)
        newBtn.setBackgroundImage(UIImage(named: "newest_button_normal"), for: .normal)
        newBtn.isSelected = true
        newBtn.tag = 100
        newBtn.setTitle("最新", for: .normal)
        newBtn.addTarget(self, action: #selector(updateWay(_:)), for: .touchUpInside)
        self.addSubview(newBtn)
//        let newLabel = UILabel(frame: CGRect(x: 15.0 * PW, y: 4 * PH, width: 78 * PW, height: 37.0 * PH))
//        newLabel.isUserInteractionEnabled = true
//        newLabel.isEnabled = true
//        newLabel.text = "最新"
//        newLabel.textColor = UIColor.white
//        newLabel.textAlignment = .center
//        self.addSubview(newLabel)
        
        hotBtn = UIButton(type: .custom)
        hotBtn.frame = CGRect(x: 99.0 * PW, y: 4 * PH, width: 78 * PW, height: 37.0 * PH)
        hotBtn.setBackgroundImage(UIImage(named: "newest_button_press"), for: .selected)
        hotBtn.setBackgroundImage(UIImage(named: "newest_button_normal"), for: .normal)
        hotBtn.tag = 101
        hotBtn.setTitle("最热", for: .normal)
        hotBtn.addTarget(self, action: #selector(updateWay(_:)), for: .touchUpInside)
        self.addSubview(hotBtn)
        
//        let hotLabel = UILabel(frame: CGRect(x: 99.0 * PW, y: 4 * PH, width: 78 * PW, height: 37.0 * PH))
//        hotLabel.isUserInteractionEnabled = true
//        hotLabel.text = "最热"
//        hotLabel.textColor = UIColor.white
//        hotLabel.textAlignment = .center
//        self.addSubview(hotLabel)
    }
    
    @objc func updateWay(_ button:UIButton) {
        
        switch button.tag {
        case 100:
            newBtn.isSelected = true
            hotBtn.isSelected = false
        case 101:
            newBtn.isSelected = false
            hotBtn.isSelected = true
        default:
            break
        }
        
        if ((delegate) != nil) {
            delegate?.LJActionShopClassifyHeaderViewBtnClick(button: button)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


