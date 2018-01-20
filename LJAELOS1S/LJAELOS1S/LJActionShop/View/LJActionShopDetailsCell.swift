//
//  LJActionShopDetailsCell.swift
//  LJAELOS1S
//
//  Created by 章卫国 on 2018/1/19.
//  Copyright © 2018年 章卫国. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class LJActionShopDetailsCell: UICollectionViewCell {
    
    var userIconImageView: UIImageView?
    var commentLabel: UILabel?
    var reReplyBtn: UIButton?
    var dateLabel: UILabel?
    var msgBtn: UIButton?
    private var tempModel: LJActionShopDetailsCommentsModel? = LJActionShopDetailsCommentsModel()
    var model: LJActionShopDetailsCommentsModel {
        set {
            tempModel = newValue
            userIconImageView?.kf.setImage(with: ImageResource(downloadURL: URL(string: (tempModel?.avatar)!)!), placeholder: UIImage(named: "small_avatar_picture_show"), options: nil, progressBlock: nil, completionHandler: nil)
            commentLabel?.text = model.content
            dateLabel?.text = (model.updateTime)! + (model.nickname)!
            msgBtn?.setTitle("\(String(describing: model.replyCount!))", for: .normal)
        }
        get {
            return self.tempModel!
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        userIconImageView = UIImageView()
        userIconImageView?.layer.cornerRadius = 30.0 * PH
        userIconImageView?.layer.masksToBounds = true;
        self.addSubview(userIconImageView!)
        userIconImageView?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(6.0 * PH)
            make.left.equalToSuperview().offset(10.0 * PW)
            make.width.height.equalTo(60.0 * PH)
        })
        
        reReplyBtn = UIButton(type: .custom)
        reReplyBtn?.setTitle("回复", for: .normal)
        reReplyBtn?.setBackgroundImage(UIImage(named: "reply_icon_normal"), for: .normal)
        reReplyBtn?.setBackgroundImage(UIImage(named: "reply_icon_press"), for: .highlighted)
        self.addSubview(reReplyBtn!)
        reReplyBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo((userIconImageView?.snp.bottom)!).offset(5.0 * PH)
            make.left.equalToSuperview().offset(10.0 * PW)
            make.width.equalTo(63.0 * PW)
            make.height.equalTo(28.0 * PH)
        })
        
        commentLabel = UILabel()
        commentLabel?.textColor = UIColor.darkGray
        commentLabel?.numberOfLines = 0
        commentLabel?.sizeToFit()
        commentLabel?.font = UIFont.systemFont(ofSize: 13.0)
        self.addSubview(commentLabel!)
        commentLabel?.snp.makeConstraints({ (make) in
            make.top.bottom.equalTo(userIconImageView!)
            make.left.equalTo((userIconImageView?.snp.right)!).offset(10.0 * PW)
            make.right.equalToSuperview().offset(-10.0 * PW)
        })
        
        dateLabel = UILabel()
        dateLabel?.font = UIFont.systemFont(ofSize: 12.0)
        dateLabel?.textColor = UIColor.darkGray
        self.addSubview(dateLabel!)
        dateLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((commentLabel?.snp.bottom)!).offset(5.0 * PH)
            make.left.equalTo((reReplyBtn?.snp.right)!).offset(10.0 * PW)
            make.width.equalTo(150.0 * PW)
            make.height.equalTo(28.0 * PH)
        })
        
        msgBtn = UIButton(type: .custom)
        msgBtn?.setImage(UIImage(named: "commnet_icon_normal"), for: .normal)
        msgBtn?.setImage(UIImage(named: "commnet_icon_press"), for: .highlighted)
        msgBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        msgBtn?.setTitleColor(UIColor.lightGray, for: .normal)
        self.addSubview(msgBtn!)
        msgBtn?.snp.makeConstraints({ (make) in
            make.left.equalTo((dateLabel?.snp.right)!)
            make.top.equalTo((commentLabel?.snp.bottom)!)
            make.right.equalToSuperview()
            make.height.equalTo(40.0 * PH)
        })
    }
    
}
