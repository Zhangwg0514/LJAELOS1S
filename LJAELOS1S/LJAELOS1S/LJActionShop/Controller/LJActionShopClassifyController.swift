//
//  LJActionShopClassifyController.swift
//  LJAELOS1S
//
//  Created by 章卫国 on 2018/1/17.
//  Copyright © 2018年 章卫国. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LJActionShopClassifyController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,LJActionShopClassifyHeaderViewDelegate,UITextFieldDelegate {
    
    var titleStr: String?
    var classify: String!
    var page: Int = 1
    var sort: String = "new"

    var naviView: UIImageView?
    var popBtn: UIButton?
    var titleLabel: UILabel?
    var searchBtn: UIButton?
    var searchTextField :UITextField = UITextField()
    
    let naviHeight = 44.0 * PH
    let btnSpacingX = 30.0 * PW
    let btnSpacingY = 40.0 * PH
    
    var refreshControl: UIRefreshControl!

    
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
        tempCollectionView.register(LJActionShopClassifyHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "LJActionShopClassifyHeaderView")
        self.view.addSubview(tempCollectionView)
        return tempCollectionView
    }()
    
    lazy var dataSource : NSMutableArray = {
        let arr = NSMutableArray()
        return arr
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGoodsListNetWork()
        initNavi()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadNewData() {
        dataSource.removeAllObjects()
        page = 1
        getGoodsListNetWork()
    }
    
    func loadMoreData() {
        page = page + 1
        getGoodsListNetWork()
    }
    
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        //收起键盘
        textField.resignFirstResponder()
        //打印出文本框中的值
        print(searchTextField.text as Any)
        return true;
    }
}
//MARK: - initUI
extension LJActionShopClassifyController {
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
        titleLabel?.text = titleStr
        titleLabel?.textColor = UIColor.white
        titleLabel?.font = UIFont.systemFont(ofSize: 18.0 * PW)
        titleLabel?.adjustsFontSizeToFitWidth = true
        naviView?.addSubview(titleLabel!)
        
        searchBtn = UIButton(type: .custom)
        searchBtn?.frame = CGRect(x: kScreenWidth - 44 * PW, y: 0, width: 44 * PW, height: naviHeight)
        searchBtn?.setImage(UIImage(named: "search_icon_normal"), for: .normal)
//        searchBtn?.setImage(UIImage(named: "search_icon_press"), for: .highlighted)
        searchBtn?.addTarget(self, action: #selector(search), for: .touchUpInside)
        naviView?.addSubview(searchBtn!)
        
        searchTextField.frame = CGRect(x: kScreenWidth - 215 * PW, y: 5, width: 200 * PW, height: naviHeight - 10)
        searchTextField.isHidden = true
        searchTextField.delegate = self
        searchTextField.background = UIImage(named: "search_icon_press")
        naviView?.addSubview(searchTextField)
        
        
    }
}

// MARK: - objc func
extension LJActionShopClassifyController {
    @objc private func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func search() {
        searchTextField.isHidden = false
    
    }
    
    func LJActionShopClassifyHeaderViewBtnClick(button: UIButton) {
        dataSource.removeAllObjects()
        switch button.tag {
        case 100:
            sort = "new"
        case 101:
            sort = "hot"
        default:
            break
        }
        getGoodsListNetWork()
    }
}

// MARK: - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension LJActionShopClassifyController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LJActionShopCell", for: indexPath) as! LJActionShopCell
        cell.model = self.dataSource[indexPath.row] as! LJActionShopModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt")
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var headerView = LJActionShopClassifyHeaderView()
        if kind == UICollectionElementKindSectionHeader {
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LJActionShopClassifyHeaderView", for: indexPath) as! LJActionShopClassifyHeaderView
        }
        headerView.delegate = self
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: PH * 207, height: PH * 78)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: kScreenWidth, height: PH * 45.0)
    }
}

// MARK: - NetWork
extension LJActionShopClassifyController {
    func getGoodsListNetWork() {
        let parameters: Parameters = ["page": page,"type": classify,"sort": sort]
        Alamofire.request("http://aelos1scn.lejurobot.com:1135/client/interface1s.php?func=getGoodsList", parameters: parameters)
            .responseJSON { response in
                switch response.result.isSuccess {
                case true:
                    //把得到的JSON数据转为数组
                    if let items = response.result.value as? NSArray{
                        //遍历数组得到每一个字典模型
                        let dict = JSON(items)
                        for index in 0...(dict.count - 1)
                        {
                            let model = LJActionShopModel()
                            //                            model.title = dict[index]["title"].string
                            if let title = dict[index]["title"].string {
                                model.title = title
                            }
                            if let downloadCount = dict[index]["downloadCount"].string {
                                model.downloadCount = downloadCount
                            }
                            if let hasAction = dict[index]["hasAction"].string {
                                model.hasAction = hasAction
                            }
                            if let id = dict[index]["id"].string {
                                model.id = id
                            }
                            if let iscollect = dict[index]["iscollect"].string {
                                model.iscollect = iscollect
                            }
                            if let isdownload = dict[index]["isdownload"].string {
                                model.isdownload = isdownload
                            }
                            if let picurl = dict[index]["picurl"].string {
                                model.picurl = picurl
                            }
                            if let second = dict[index]["second"].string {
                                model.second = second
                            }
                            if let titlestream = dict[index]["titlestream"].string {
                                model.titlestream = titlestream
                            }
                            if let type = dict[index]["type"].string {
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

