//
//  LJAboutView.swift
//  LJAELOS1S
//
//  Created by 章卫国 on 2018/1/20.
//  Copyright © 2018年 章卫国. All rights reserved.
//

import UIKit
import SnapKit

class LJAboutView: UIView {
    
    var grayBackground: UIImageView?
    var currentVesionLabel: UILabel?
    var newVesionLabel: UILabel?
    var updateBtn: UIButton?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        
        grayBackground = UIImageView()
        grayBackground?.image = UIImage(named: "gray_background")
        grayBackground?.isUserInteractionEnabled = true
        self.addSubview(grayBackground!)
        grayBackground?.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.equalTo(350.0 * PW)
            make.height.equalTo(175.0 * PH)
        }
        
        let whiteBackground: UIImageView = UIImageView()
        whiteBackground.image = UIImage(named: "whiteBackground")
        grayBackground?.addSubview(whiteBackground)
        
        whiteBackground.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(15.0 * PH)
            make.right.equalToSuperview().offset(-15 * PH)
            make.height.equalTo(100.0 * PH)
        }
        
        currentVesionLabel = UILabel()
        currentVesionLabel?.text = "当前版本:" + "1.3.2"
        currentVesionLabel?.textAlignment = .center
        whiteBackground.addSubview(currentVesionLabel!)
        currentVesionLabel?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(30.0 * PH)
            make.width.left.equalToSuperview()
            make.height.equalTo(20.0 * PH)
        })
        
        newVesionLabel = UILabel()
        newVesionLabel?.text = "最新版本:" + "1.3.6"
        newVesionLabel?.textAlignment = .center
        whiteBackground.addSubview(newVesionLabel!)
        newVesionLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo((currentVesionLabel?.snp.bottom)!)
            make.width.left.equalToSuperview()
            make.height.equalTo(20.0 * PH)
        })
        
        updateBtn = UIButton(type: .custom)
        updateBtn?.setTitle("更新", for: .normal)
        updateBtn?.addTarget(self, action: #selector(updateVersion), for: .touchUpInside)
        updateBtn?.setBackgroundImage(UIImage(named: "update_button_press"), for: .normal)
        grayBackground?.addSubview(updateBtn!)
        updateBtn?.snp.makeConstraints({ (make) in
            make.top.equalTo(whiteBackground.snp.bottom).offset(10.0 * PH)
            make.left.right.equalTo(whiteBackground)
            make.height.equalTo(40.0 * PH)
        })
        
        let closeBtn: UIButton = UIButton(type: .custom)
        closeBtn.setImage(UIImage(named: "x_icon_normal"), for: .normal)
        closeBtn.setImage(UIImage(named: "x_icon_press"), for: .highlighted)
        closeBtn.addTarget(self, action: #selector(close), for: .touchUpInside)
        grayBackground?.addSubview(closeBtn)
        closeBtn.snp.makeConstraints { (make) in
            make.center.equalTo(CGPoint(x: (grayBackground?.frame.maxX)! + (350.0 * PW), y: (grayBackground?.frame.maxY)!))
            make.width.height.equalTo(35.0 * PH)
        }
    }
    
    @objc private func updateVersion() {
        UIApplication.shared.openURL(URL(string: APPSTORE_URL)!)
    }
    
    @objc private func close() {
        self.removeFromSuperview()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let t:UITouch = touch as! UITouch
            if(!(t.view?.isEqual(grayBackground))!) {
                self.removeFromSuperview()
            }
        }
    }
}
