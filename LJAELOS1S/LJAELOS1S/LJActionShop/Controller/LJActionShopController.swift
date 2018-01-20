//
//  LJActionShopController.swift
//  LJAELOS1S
//
//  Created by 章卫国 on 2018/1/11.
//  Copyright © 2018年 章卫国. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class LJActionShopController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,LJActionShopHeaderViewDelegate {
    
    var naviView: UIImageView?
    var popBtn: UIButton?
    var titleLabel: UILabel?
    var bluetoothBtn: UIButton?
    let naviHeight = 44.0 * PH
    let btnSpacingX = 30.0 * PW
    let btnSpacingY = 40.0 * PH
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 3 * PW
        flowLayout.minimumInteritemSpacing = 8 * PH
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 15 * PW, bottom: 0, right: 15 * PW)
        let tempCollectionView = UICollectionView(frame: CGRect(x: 0, y: 44.0 * PH, width: kScreenWidth, height: kScreenHeight - 44.0 * PH), collectionViewLayout:flowLayout)
        tempCollectionView.backgroundColor = UIColor(red: 236.0 / 255.0, green: 235.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0)
        tempCollectionView.delegate = self
        tempCollectionView.dataSource = self
        tempCollectionView.register(LJActionShopCell.self, forCellWithReuseIdentifier: "LJActionShopCell")
        tempCollectionView.register(LJActionShopHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "LJActionShopHeaderView")
        self.view.addSubview(tempCollectionView)
        return tempCollectionView
    }()
    
    lazy var dataSource : NSMutableArray = {
        let arr = NSMutableArray()
        return arr
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavi()
        getHotGoodsListNetWork()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - LJActionShopHeaderViewDelegate
    func LJActionShopHeaderViewClassBtnClick(button: UIButton) {
        let vc = LJActionShopClassifyController()
        switch button.tag {
        case 0:
            vc.classify = "0"
            vc.titleStr = "常规"
        case 1:
            vc.classify = "1"
            vc.titleStr = "拳击"
        case 2:
            vc.classify = "2"
            vc.titleStr = "足球"
        case 3:
            vc.classify = "3"
            vc.titleStr = "舞蹈"
        case 4:
            vc.classify = "4"
            vc.titleStr = "故事"
        case 5:
            vc.classify = "5"
            vc.titleStr = "原创"
            
        default:
            break
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - initUI
extension LJActionShopController {
    func initNavi() {
        naviView = UIImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: naviHeight))
        naviView?.isUserInteractionEnabled = true
        naviView?.image = UIImage(named: "ActionCollecterNav")
        self.view .addSubview(naviView!)
        
        popBtn = UIButton(type: .custom)
        popBtn?.setImage(UIImage(named: "back_icon-normal"), for: .normal)
        popBtn?.setImage(UIImage(named: "back_icon-press"), for: .highlighted)
        popBtn?.frame = CGRect(x: 0, y: 0, width: 44 * PW, height: 44 * PH)
        popBtn?.addTarget(self, action: #selector(pop), for: .touchUpInside)
        naviView?.addSubview(popBtn!)
        
        titleLabel = UILabel(frame: CGRect(x: (kScreenWidth - 200) / 2, y: 0, width: 200, height: naviHeight))
        titleLabel?.textAlignment = .center
        titleLabel?.text = "动作市场"
        titleLabel?.textColor = UIColor.white
        titleLabel?.font = UIFont.systemFont(ofSize: 18.0 * PW)
        titleLabel?.adjustsFontSizeToFitWidth = true
        naviView?.addSubview(titleLabel!)
        
        let downFileBtn = UIButton(type: .custom)
        downFileBtn.frame = CGRect(x: kScreenWidth - 94 * PW, y: 0, width: 44 * PW, height: naviHeight)
        downFileBtn.setImage(UIImage(named: "down_info_icon_normal"), for: .normal)
        downFileBtn.setImage(UIImage(named: "down_info_icon_normal"), for: .highlighted)
        downFileBtn.addTarget(self, action: #selector(downFile), for: .touchUpInside)
        naviView?.addSubview(downFileBtn)
        
        bluetoothBtn = UIButton(type: .custom)
        bluetoothBtn?.frame = CGRect(x: kScreenWidth - 44 * PW, y: 0, width: 44 * PW, height: naviHeight)
        bluetoothBtn?.setImage(UIImage(named: "bluetooth_connect_icon_normal"), for: .normal)
        bluetoothBtn?.setImage(UIImage(named: "bluetooth_connect_icon_press"), for: .highlighted)
        bluetoothBtn?.addTarget(self, action: #selector(bluetoothState), for: .touchUpInside)
        naviView?.addSubview(bluetoothBtn!)
    }
}
// MARK: - objc func
extension LJActionShopController {
    @objc private func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func bluetoothState() {
        print("bluetoothState()")
    }
    @objc private func downFile() {
        print("downFile()")
    }
    
}
// MARK: - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension LJActionShopController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LJActionShopCell", for: indexPath) as! LJActionShopCell
        cell.model = self.dataSource[indexPath.row] as! LJActionShopModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = LJActionShopDetailsController()
        let model = self.dataSource[indexPath.row] as! LJActionShopModel
        vc.actionId = model.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var headerView = LJActionShopHeaderView()
        if kind == UICollectionElementKindSectionHeader {
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LJActionShopHeaderView", for: indexPath) as! LJActionShopHeaderView
        }
        headerView.delegate = self
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: PH * 207, height: PH * 78)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: kScreenWidth, height: PH * 218.0)
    }
}

// MARK: - NetWork
extension LJActionShopController {
    func getHotGoodsListNetWork() {
        let parameters: Parameters = ["page": "1"]
        Alamofire.request("http://aelos1scn.lejurobot.com:1135/client/interface1s.php?func=getHotGoodsList", parameters: parameters)
            .responseJSON { response in
                switch response.result.isSuccess {
                case true:
                    //把得到的JSON数据转为数组
                    if let items = response.result.value as? NSArray{
                        //遍历数组得到每一个字典模型
                        let arr = JSON(items)
                        for index in 0...(arr.count - 1) {
                            let model = LJActionShopModel()
//                            model.title = dict[index]["title"].string
                            if let title = arr[index]["title"].string {
                                model.title = title
                            }
                            if let downloadCount = arr[index]["downloadCount"].string {
                                model.downloadCount = downloadCount
                            }
                            if let hasAction = arr[index]["hasAction"].string {
                                model.hasAction = hasAction
                            }
                            if let id = arr[index]["id"].string {
                                model.id = id
                            }
                            if let iscollect = arr[index]["iscollect"].string {
                                model.iscollect = iscollect
                            }
                            if let isdownload = arr[index]["isdownload"].string {
                                model.isdownload = isdownload
                            }
                            if let picurl = arr[index]["picurl"].string {
                                model.picurl = picurl
                            }
                            if let second = arr[index]["second"].string {
                                model.second = second
                            }
                            if let titlestream = arr[index]["titlestream"].string {
                                model.titlestream = titlestream
                            }
                            if let type = arr[index]["type"].string {
                                model.type = type
                            }
                            self.dataSource.add(model)
                        }
                        self.collectionView.reloadData()
                    }
                case false:
                    print(response.result.error as Any)
                }
        }
        
    }
}






