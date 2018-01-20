//
//  LJActionShopCell.swift
//  LJAELOS1S
//
//  Created by 章卫国 on 2018/1/12.
//  Copyright © 2018年 章卫国. All rights reserved.
//

import UIKit
import Kingfisher

class LJActionShopCell: UICollectionViewCell {
    
    var iconImageView: UIImageView?
    var nameLabel: UILabel?
    var stautsBtn: UIButton?
    var timeLabel: UILabel?
    var sizeLabel: UILabel?
    private var tempModel:LJActionShopModel? = LJActionShopModel()
    var model: LJActionShopModel {
        set {
            tempModel = newValue
            timeLabel?.text = tempModel?.second
            nameLabel?.text = tempModel?.title
            sizeLabel?.text = tempModel?.titlestream
            iconImageView?.kf.setImage(with: ImageResource(downloadURL: URL(string: (tempModel?.picurl)!)!), placeholder: UIImage(named: "icon"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        get {
            return (self.tempModel)!
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        initUI()
    }
    
    func initUI() {
        
        iconImageView = UIImageView(frame: CGRect(x: 10 * PW, y: 8 * PH, width: 60 * PW, height: 60 * PH))
        iconImageView?.layer.cornerRadius = 30 * PW
        iconImageView?.layer.masksToBounds = true;
        self.addSubview(iconImageView!)
        
        nameLabel = UILabel(frame: CGRect(x: 76 * PW, y: 13 * PH, width: 90 * PW, height: 15 * PH))
        nameLabel?.numberOfLines = 0
        nameLabel?.adjustsFontSizeToFitWidth = true
        self.addSubview(nameLabel!)
        
        let timeIcomImageView = UIImageView(frame: CGRect(x: 76 * PW, y: 45 * PH, width: 15.0 * PW, height: 15 * PH))
        timeIcomImageView.image = UIImage(named: "time_icon")
        self.addSubview(timeIcomImageView)
        
        timeLabel = UILabel(frame: CGRect(x: 98 * PW, y: 47 * PH, width: 65 * PW, height: 11 * PH))
        timeLabel?.font = UIFont.systemFont(ofSize: 11.0 * PH)
        timeLabel?.textColor = UIColor.lightGray
        timeLabel?.adjustsFontSizeToFitWidth = true
        self.addSubview(timeLabel!)
        
        stautsBtn = UIButton(type: .custom)
        stautsBtn?.frame = CGRect(x: 166 * PW, y: 18 * PH, width: 25 * PW, height: 25 * PH)
        stautsBtn?.setImage(UIImage(named: "download_icon"), for: .normal)
        self.addSubview(stautsBtn!)
        
        sizeLabel = UILabel(frame: CGRect(x: 166 * PW, y: 43 * PH, width: 25 * PW, height: 15 * PH))
        sizeLabel?.textColor = UIColor.darkGray
        sizeLabel?.textAlignment = .center
        sizeLabel?.adjustsFontSizeToFitWidth = true
        self.addSubview(sizeLabel!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

