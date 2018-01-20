//
//  LJActionShopDetailsController.swift
//  LJAELOS1S
//
//  Created by 章卫国 on 2018/1/17.
//  Copyright © 2018年 章卫国. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AVFoundation
import AVKit

class LJActionShopDetailsController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,LJActionShopDetailsHeaderViewDelegate {

    var actionId: String?
    var naviView: UIImageView?
    var popBtn: UIButton?
    var titleLabel: UILabel?
    var bluetoothBtn: UIButton?
    let naviHeight = 44.0 * PH
    let btnSpacingX = 30.0 * PW
    let btnSpacingY = 40.0 * PH
    
    let model = LJActionShopDetailsHeaderModel()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 3 * PW
        flowLayout.minimumInteritemSpacing = 5 * PH
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 15 * PW, bottom: 0, right: 15 * PW)
        let tempCollectionView = UICollectionView(frame: CGRect(x: 0, y: 44.0 * PH, width: kScreenWidth, height: kScreenHeight - 44.0 * PH), collectionViewLayout:flowLayout)
        tempCollectionView.backgroundColor = UIColor(red: 236.0 / 255.0, green: 235.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0)
        tempCollectionView.delegate = self
        tempCollectionView.dataSource = self
        tempCollectionView.register(LJActionShopDetailsCell.self, forCellWithReuseIdentifier: "LJActionShopDetailsCell")
        tempCollectionView.register(LJActionShopDetailsHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "LJActionShopDetailsHeaderView")
        self.view.addSubview(tempCollectionView)
        return tempCollectionView
    }()
    
    lazy var commentsDataSource : NSMutableArray = {
        let arr = NSMutableArray()
        return arr
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGoodsFromNetWork()
        getCommentsNetWork()
        initNavi()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - initUI
extension LJActionShopDetailsController {
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
        titleLabel?.text = "动作详情"
        titleLabel?.textColor = UIColor.white
        titleLabel?.font = UIFont.systemFont(ofSize: 18.0 * PW)
        titleLabel?.adjustsFontSizeToFitWidth = true
        naviView?.addSubview(titleLabel!)
    }
}

// MARK: - objc func
extension LJActionShopDetailsController {
    @objc private func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func LJActionShopDetailsHeaderViewPlayerClick() {
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.addSubview(view)
        
        guard let url = URL(string: "http://bos.nj.bpc.baidu.com/tieba-smallvideo/11772_3c435014fb2dd9a5fd56a57cc369f6a0.mp4") else {
            return
        }
        
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
}

// MARK: - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension LJActionShopDetailsController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return commentsDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LJActionShopDetailsCell", for: indexPath) as! LJActionShopDetailsCell
        cell.model = self.commentsDataSource[indexPath.row] as! LJActionShopDetailsCommentsModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt")
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var headerView = LJActionShopDetailsHeaderView()
        if kind == UICollectionElementKindSectionHeader {
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LJActionShopDetailsHeaderView", for: indexPath) as! LJActionShopDetailsHeaderView
        }
        headerView.delegate = self 
        headerView.model = self.model
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: PH * 316.0, height: PH * 108.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: kScreenWidth, height: PH * 160.0)
    }
}

// MARK: - NetWork
extension LJActionShopDetailsController {
    func getGoodsFromNetWork() {
        let parameters: Parameters = ["userid": "qweqwe","id": actionId!]
        let url: URL = URL(string: "http://aelos1scn.lejurobot.com:1135/client/interface1s.php?func=getGoods")!
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON  { (response) in
            switch response.result.isSuccess {
                case true:
                    if let value = response.result.value {
                        let json = JSON(value)
                        self.model.filestream = json[0]["filestream"].string
                        self.model.thumbnails = json[0]["thumbnails"].string
                        self.model.isdownload = json[0]["isdownload"].string
                        self.model.type = json[0]["type"].string
                        self.model.downloadCount = json[0]["downloadCount"].int
                        self.model.picurl = json[0]["picurl"].string
                        self.model.content = json[0]["content"].string
                        self.model.update_time = json[0]["update_time"].string
                        self.model.collectCount = json[0]["collectCount"].int
                        self.model.videopicurl = json[0]["videopicurl"].string
                        self.model.video = json[0]["video"].string
                        self.model.titlestream = json[0]["titlestream"].string
                        self.model.id = json[0]["id"].string
                        self.model.iscollect = json[0]["iscollect"].string
                        self.model.second = json[0]["second"].string
                        self.model.hasAction = json[0]["hasAction"].string
                        self.model.title = json[0]["title"].string
                        self.model.user_nickname = json[0]["user_nickname"].string
                        self.model.isApplaud = json[0]["isApplaud"].string
                        self.model.audio = json[0]["audio"].string
                        self.model.commentCount = json[0]["commentCount"].int
                        self.model.applaudCount = json[0]["applaudCount"].int
                    }
                    self.collectionView.reloadData()
                case false:
                    print(response.result.error as Any)
            }
        }
    }
    
    func getCommentsNetWork() {
        let parameters: Parameters = ["page": 1,"goodsid": actionId!]
        let url: URL = URL(string: "http://aelos1scn.lejurobot.com:1135/client/interface1s.php?func=getComments")!
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON  { (response) in
            switch response.result.isSuccess {
            case true:
                if let items = response.result.value {
                    //遍历数组得到每一个字典模型
                    let arr = JSON(items)
                    for index in 0...(arr.count - 1) {
                        let model = LJActionShopDetailsCommentsModel()
                        model.content = arr[index]["content"].string
                        model.sequence = arr[index]["sequence"].int
                        model.id = arr[index]["id"].string
                        model.updateTime = arr[index]["updateTime"].string
                        model.avatar = arr[index]["avatar"].string
                        model.nickname = arr[index]["nickname"].string
                        model.replyCount = arr[index]["replyCount"].int
                        model.userid = arr[index]["userid"].string
                        self.commentsDataSource.add(model)
                    }
                    self.collectionView.reloadData()
                }
            case false:
                print(response.result.error as Any)
            }
        }
    }
    
}
