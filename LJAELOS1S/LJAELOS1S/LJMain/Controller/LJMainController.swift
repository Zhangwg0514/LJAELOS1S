//
//  LJMainController.swift
//  LJAELOS1S
//
//  Created by 章卫国 on 2018/1/11.
//  Copyright © 2018年 章卫国. All rights reserved.
//

import UIKit

class LJMainController: UIViewController,LJMainMenuViewDelegate {

    var naviView: UIImageView?
    var userStateBtn: UIButton?
    var titleLabel: UILabel?
    var bluetoothBtn: UIButton?
    let naviHeight = 44.0 * PH
    let btnSpacingX = 30.0 * PW
    let btnSpacingY = 40.0 * PH
    
    var menuView: LJMainMenuView?

    override func viewDidLoad() {
        super.viewDidLoad()
        initNavi()
        initMainUI()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
// MARK: - initUI
extension LJMainController {
    func initNavi() {
        naviView = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: naviHeight))
        naviView?.isUserInteractionEnabled = true
        naviView?.image = UIImage(named: "ActionCollecterNav")
        self.view .addSubview(naviView!)
        
        userStateBtn = UIButton(type: .custom)
        userStateBtn?.setImage(UIImage(named: "me_icon_normal"), for: .normal)
        userStateBtn?.setImage(UIImage(named: "me_icon_press"), for: .highlighted)
        userStateBtn?.frame = CGRect(x: 0, y: 0, width: 44 * PW, height: 44 * PH)
        userStateBtn?.addTarget(self, action: #selector(menu), for: .touchUpInside)
        naviView?.addSubview(userStateBtn!)
        
        titleLabel = UILabel(frame: CGRect(x: (kScreenWidth - 200) / 2, y: 0, width: 200, height: naviHeight))
        titleLabel?.textAlignment = .center
        titleLabel?.text = "AELOS 1S"
        titleLabel?.textColor = UIColor.white
        titleLabel?.font = UIFont.systemFont(ofSize: 18.0 * PW)
        titleLabel?.adjustsFontSizeToFitWidth = true
        naviView?.addSubview(titleLabel!)
        
        bluetoothBtn = UIButton(type: .custom)
        bluetoothBtn?.frame = CGRect(x: kScreenWidth - 44 * PW, y: 0, width: 44 * PW, height: naviHeight)
        bluetoothBtn?.setImage(UIImage(named: "bluetooth_connect_icon_normal"), for: .normal)
        bluetoothBtn?.setImage(UIImage(named: "bluetooth_connect_icon_press"), for: .highlighted)
        bluetoothBtn?.addTarget(self, action: #selector(bluetoothState), for: .touchUpInside)
        naviView?.addSubview(bluetoothBtn!)
    }
    
    func initMainUI() {
        let arr:Array = ["action_store_backgroud","game_pad_background","diy_action_background","动作市场","遥控器","DIY动作"]
        
        for i in 0..<3 {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: btnSpacingX + ((kScreenWidth - 4 * btnSpacingX) / 3 + btnSpacingX) * CGFloat(i), y: naviHeight + btnSpacingY, width: (kScreenWidth - 4 * btnSpacingX) / 3, height: kScreenHeight - naviHeight - 2 * btnSpacingY)
            button.setImage(UIImage(named: arr[i]), for: .normal)
            button.addTarget(self, action: #selector(mainBtn(_:)), for: .touchUpInside)
            button.tag = i
            self.view.addSubview(button)
            
            let titleLabel = UILabel(frame: CGRect(x: btnSpacingX + ((kScreenWidth - 4 * btnSpacingX) / 3 + btnSpacingX) * CGFloat(i), y: kScreenHeight - btnSpacingY - 50 * PH, width: (kScreenWidth - 4 * btnSpacingX) / 3, height: 50 * PH))
            titleLabel.text = arr[i + 3]
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.init(name: "PingFang SC", size: 18.0 * PW)
            if i == 0 {
                titleLabel.textColor = UIColor(red: 3.0/255.0, green: 163.0/255.0, blue: 239.0/255.0, alpha: 1.0)
            } else if i == 1 {
                titleLabel.textColor = UIColor(red: 255.0/255.0, green: 155.0/255.0, blue: 94.0/255.0, alpha: 1.0)
            } else if i == 2 {
                titleLabel.textColor = UIColor(red: 101.0/255.0, green: 151.0/255.0, blue: 1.0/255.0, alpha: 1.0)
            }
            self.view.addSubview(titleLabel)
        }
    }
}
// MARK: - objc func
extension LJMainController {
    @objc private func menu() {
        menuView = LJMainMenuView(frame: self.view.bounds)
        menuView?.delegate = self
        self.view.addSubview(menuView!)
    }
    
    @objc private func bluetoothState() {
        print("bluetoothState()")
    }
    
    func LJMainMenuViewDidSelectRowAt(indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("LJMainMenuViewDidSelectRowAt" + "\(indexPath.row)")
        case 1:
            print("LJMainMenuViewDidSelectRowAt" + "\(indexPath.row)")
        case 2:
            print("LJMainMenuViewDidSelectRowAt" + "\(indexPath.row)")
        case 3:
            print("LJMainMenuViewDidSelectRowAt" + "\(indexPath.row)")
        case 4:
            let aboutView = LJAboutView()
            aboutView.frame = self.view.bounds
            self.view.addSubview(aboutView)
            
        default:
            break
        }
    }
    
    @objc private func mainBtn(_ button:UIButton) {
        switch button.tag {
        case 0:
            let actionShopVC = LJActionShopController()
            self.navigationController?.pushViewController(actionShopVC, animated: true)
            break
        case 1:
            let gamePadVC = LJGamePadController()
            self.navigationController?.pushViewController(gamePadVC, animated: true)
            break
        case 2:
            let DIYVC = LJDIYController()
            self.navigationController?.pushViewController(DIYVC, animated: true)
            break
        default:
            break
        }
    }
}


