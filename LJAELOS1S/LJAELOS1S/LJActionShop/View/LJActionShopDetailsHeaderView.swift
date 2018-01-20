//
//  LJActionShopDetailsHeaderView.swift
//  LJAELOS1S
//
//  Created by 章卫国 on 2018/1/17.
//  Copyright © 2018年 章卫国. All rights reserved.
//

import UIKit
import Kingfisher

protocol LJActionShopDetailsHeaderViewDelegate : NSObjectProtocol {
    
    func LJActionShopDetailsHeaderViewPlayerClick()
    
}

class LJActionShopDetailsHeaderView: UICollectionReusableView {
    
    weak var delegate: LJActionShopDetailsHeaderViewDelegate?
    
    var playerBackImageView: UIImageView?
    var nameLabel: UILabel?
    var describeLabel: UILabel?
    var userIcon: UIImageView?
    var thumbsUp: UIButton?
    var download: UIButton?
    
    var userName: UIButton?
    var time: UIButton?

    private var tempModel:LJActionShopDetailsHeaderModel? = LJActionShopDetailsHeaderModel()
    var model: LJActionShopDetailsHeaderModel {
        set {
            tempModel = newValue
            nameLabel?.text = tempModel?.title
            describeLabel?.text = tempModel?.content

            userIcon?.kf.setImage(with: ImageResource(downloadURL: URL(string: (tempModel?.picurl)!)!), placeholder: UIImage(named: "icon"), options: nil, progressBlock: nil, completionHandler: nil)
            
            thumbsUp?.setTitle("\(String(describing: (tempModel?.applaudCount)!))", for: .normal)
            download?.setTitle("\(String(describing: (tempModel?.downloadCount)!))", for: .normal)
            time?.setTitle("\(String(describing: (tempModel?.update_time)!))", for: .normal)
            userName?.setTitle("\(String(describing: (tempModel?.user_nickname)!))", for: .normal)

        }
        
        get {
            return self.tempModel!
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        playerBackImageView = UIImageView(frame: CGRect(x: 15.0 * PW, y: 5, width: 200 * PW, height: 150 * PH))
        playerBackImageView?.isUserInteractionEnabled = true
        playerBackImageView?.image = UIImage(named: "banner_show_picture")
        self.addSubview(playerBackImageView!)
        
        let playerBtn = UIButton(type: .custom)
        playerBtn.frame = CGRect(x: 60.0 * PW, y: 30.0 * PH, width: 80.0 * PW, height: 80.0 * PH)
        playerBtn.alpha = 0.6
        playerBtn.addTarget(self, action: #selector(player), for: .touchUpInside)
        playerBtn.setImage(UIImage(named: "playButton"), for: .normal)
        playerBackImageView?.addSubview(playerBtn)
        
        let containerView = UIView(frame: CGRect(x: 215.0 * PW, y: 5 * PH, width: kScreenWidth - 230.0 * PW, height: 150.0 * PH))
        containerView.backgroundColor = UIColor.white
        self.addSubview(containerView)
        
        nameLabel = UILabel(frame: CGRect(x: 5.0 * PW, y: 20.0 * PH, width: 230.0 * PW, height: 20.0 * PH))
        nameLabel?.font = UIFont.systemFont(ofSize: 18.0 * PW)
        containerView.addSubview(nameLabel!)
        
        describeLabel = UILabel(frame: CGRect(x: 5.0 * PW, y: 40.0 * PH, width: 230.0 * PW, height: 60.0 * PH))
        describeLabel?.font = UIFont.systemFont(ofSize: 12.0 * PW, weight: UIFont.Weight(rawValue: 1.0))
        describeLabel?.textColor = UIColor.darkGray
        describeLabel?.numberOfLines = 0
        describeLabel?.sizeToFit()
        containerView.addSubview(describeLabel!)
        
        userIcon = UIImageView(frame: CGRect(x: 285.0 * PW, y: 15.0 * PH, width: 72.0 * PW, height: 72.0 * PH))
        userIcon?.layer.cornerRadius = 36.0 * PW
        userIcon?.layer.masksToBounds = true;
        containerView.addSubview(userIcon!)
        
        thumbsUp = UIButton(type: .custom)
        thumbsUp?.frame = CGRect(x: 5.0 * PW, y: 110.0 * PH, width: 100.0 * PW, height: 40.0 * PH)
        thumbsUp?.setImage(UIImage(named: "good_icon_press"), for: .normal)
        thumbsUp?.setTitleColor(UIColor.darkGray, for: .normal)
        thumbsUp?.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        thumbsUp?.titleLabel?.isUserInteractionEnabled = false
        containerView.addSubview(thumbsUp!)
        
        download = UIButton(type: .custom)
        download?.frame = CGRect(x: 110.0 * PW, y: 110.0 * PH, width: 100.0 * PW, height: 40.0 * PH)
        download?.setImage(UIImage(named: "download_icon_normal"), for: .normal)
        download?.setTitleColor(UIColor.darkGray, for: .normal)
        download?.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        download?.titleLabel?.isUserInteractionEnabled = false
        containerView.addSubview(download!)
        
        userName = UIButton(type: .custom)
        userName?.frame = CGRect(x: 260.0 * PW, y: 100.0 * PH, width: 115.0 * PW, height: 15.0 * PH)
        userName?.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        userName?.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0.0 * PW)
        userName?.setImage(UIImage(named: "crown_icon"), for: .normal)
        userName?.setTitleColor(UIColor.darkGray, for: .normal)
        userName?.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        userName?.isUserInteractionEnabled = false
        containerView.addSubview(userName!)
        
        time = UIButton(type: .custom)
        time?.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        time?.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0.0 * PW)
        time?.frame = CGRect(x: 260.0 * PW, y: 130.0 * PH, width: 150 * PW, height: 15.0 * PH)
        time?.setImage(UIImage(named: "time_icon"), for: .normal)
        time?.setTitleColor(UIColor.darkGray, for: .normal)
        time?.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        time?.isUserInteractionEnabled = false
        containerView.addSubview(time!)
    }
    
    @objc func player() {
        if ((delegate) != nil) {
            delegate?.LJActionShopDetailsHeaderViewPlayerClick()
        }
    }
}
