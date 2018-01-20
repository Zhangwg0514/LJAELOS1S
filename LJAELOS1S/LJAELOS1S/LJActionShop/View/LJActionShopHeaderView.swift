//
//  LJActionShopHeaderView.swift
//  LJAELOS1S
//
//  Created by 章卫国 on 2018/1/12.
//  Copyright © 2018年 章卫国. All rights reserved.
//

import UIKit

protocol LJActionShopHeaderViewDelegate : NSObjectProtocol {
    
    func LJActionShopHeaderViewClassBtnClick(button:UIButton)
    
}

class LJActionShopHeaderView: UICollectionReusableView {
    
    var bannerView: UIImageView?
    var classView: UIView?
    weak var delegate: LJActionShopHeaderViewDelegate?
    
    
    let imageArray = ["action_icon","boxing_icon","football_icon","music_icon","carb_icon","upload_icon"]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initHeaderViewUI()
        initClassButton()
    }
    
    func initHeaderViewUI() {
        bannerView = UIImageView(frame: CGRect(x: 15.0 * PW, y: 0.0, width: 373.0 * PW, height: 164.0 * PH))
        bannerView?.image = UIImage(named: "banner")
        self.addSubview(bannerView!)
        
        classView = UIView(frame: CGRect(x: 394.0 * PW, y: 0.0, width: 258.0 * PW, height: 164.0 * PH))
        classView?.backgroundColor = UIColor.white
        self.addSubview(classView!)
        
        let popularlyRecommendLabel = UILabel(frame: CGRect(x: 15.0 * PW, y: 170.0 * PH, width: kScreenWidth - 30.0 * PW, height: 39.0 * PH))
        popularlyRecommendLabel.backgroundColor = UIColor.white
        popularlyRecommendLabel.textAlignment = .center
        popularlyRecommendLabel.font = UIFont.boldSystemFont(ofSize: 16.0 * PW)
        popularlyRecommendLabel.textColor = UIColor(red: 58.0/255.0, green: 189.0/255.0, blue: 251.0/255.0, alpha: 1.0)
        popularlyRecommendLabel.text = "Popularly Recommend"
        self.addSubview(popularlyRecommendLabel)
    }
    
    func initClassButton() {
        for i in 0..<6 {
            let button = UIButton(type: .custom)
            button.tag = i
            button.frame = CGRect(x:(CGFloat(i % 3) * (78 + 6) + 6) * PW , y: (CGFloat(i / 3) * (6 + 73) + 6) * PH, width: 78 * PW, height: 73 * PH)
            button.setImage(UIImage(named: imageArray[i]), for: .normal)
            button.addTarget(self, action: #selector(classBtn(_:)), for: .touchUpInside)
            classView?.addSubview(button)
        }
    }
    
    @objc func classBtn(_ button:UIButton) {
        if ((delegate) != nil) {
            delegate?.LJActionShopHeaderViewClassBtnClick(button: button)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
