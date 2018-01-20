//
//  LJMainMenuView.swift
//  LJAELOS1S
//
//  Created by 章卫国 on 2018/1/11.
//  Copyright © 2018年 章卫国. All rights reserved.
//

import UIKit

protocol LJMainMenuViewDelegate {
    
    func LJMainMenuViewDidSelectRowAt(indexPath: IndexPath)
    
}

class LJMainMenuView: UIView,UITableViewDelegate,UITableViewDataSource
{
    var delegate: LJMainMenuViewDelegate?
    var menuTableView: UITableView?
    let dataSource = ["Not Login","Robot Network","Setting","Q&A","About","not_login_icon_normal","wifi_icon_normal","settings_icon_normal","qa_icon_normal","about_icon_normal"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        initMenuUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initMenuUI() {
        
        let backgroundImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 240.0 * PW, height: 270.0 * PH))
        backgroundImageView.isUserInteractionEnabled = true
        backgroundImageView.image = UIImage(named: "left_gray_background")
        self.addSubview(backgroundImageView)
        
        menuTableView = UITableView()
        menuTableView?.frame = CGRect(x: 10.0 * PW, y: 10.0 * PH, width: 220 * PW, height: 250.0 * PH)
        menuTableView?.layer.cornerRadius = 10 * PW;
        menuTableView?.separatorStyle = .none
        menuTableView?.delegate = self
        menuTableView?.dataSource = self
        menuTableView?.isScrollEnabled = false
        menuTableView?.rowHeight = UITableViewAutomaticDimension
        menuTableView?.rowHeight = 50 * PH
        menuTableView?.register(UITableViewCell.self, forCellReuseIdentifier: "menuCell")
        backgroundImageView.addSubview(menuTableView!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let t:UITouch = touch as! UITouch
            if(!(t.view?.isEqual(menuTableView))!) {
                self.removeFromSuperview()
            }
        }
    }
}
// MARK: - UITableViewDelegate,UITableViewDataSource
extension LJMainMenuView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)) as UITableViewCell
        let iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 220 * PW, height: 50 * PH))
        iconImageView.image = UIImage(named: dataSource[indexPath.row + 5])
        cell.addSubview(iconImageView)
        
        let textLabel = UILabel(frame: CGRect(x: 50.0 * PW, y: 0, width: 170.0 * PW, height: 50 * PH))
        textLabel.text = dataSource[indexPath.row]
        cell.addSubview(textLabel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.removeFromSuperview()
        if ((delegate) != nil) {
            delegate?.LJMainMenuViewDidSelectRowAt(indexPath: indexPath)
        }
    }
}

