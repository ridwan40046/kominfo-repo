//
//  InboxVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Asad Ardiansyah on 13/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

class InboxVc: BaseVc {
    var inbox: InboxObj? {didSet {reloadDisplay() } }
    var listInbox: ListsObj? { didSet { reloadDisplay() }}
    var refreshControl: UIRefreshControl?;
    @IBOutlet weak var tv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
<<<<<<< HEAD
        reloadData()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(self.reloadData), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tv?.refreshControl = refreshControl
        } else {
            // Fallback on earlier versions
            tv?.addSubview(refreshControl!)
        }
=======
        engine.getInboxes()
>>>>>>> master
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = false
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc func reloadData(){
        self.refreshControl?.endRefreshing()
        Util.showIndicatorDarkOverlay(self.view)
        engine.getInboxes(){
            Util.stopIndicator(self.view)
            if $0?.isSuccess ?? false {
                self.listInbox = $0?.inboxes?.list
                print ("dict:\(self.listInbox?.arr?.summary ?? "")")
            }else {
                toast("\($0?.message ?? "")")
            }
        }
    }
    func reloadDisplay(){
        self.tv.reloadData()
    }
    override func setNavBar() {
        super.setNavBar()
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        
    }
}

extension InboxVc: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("ini jumlah : \(listInbox?.count)")
        return (listInbox?.count ?? 0) + 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, cellForRowAt: indexPath).height
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (_, 0):
            let cell = tableView.cell("header")!
            cell.Label(1).text = "Senin"
            cell.Label(2).text = "08 October 2018"
            return cell
        case(0, _):
            let cell = tableView.cell("message")!
            let data = listInbox?[indexPath.row - 1]
            let photo = cell.Label(1)
            photo.text = data?.letterType?.getInisial()
            photo.makeRounded()
            photo.backgroundColor = UIColor.orange

            let nama = cell.Label(2)
      //      print("letter subject: \(data?.dict?.summary)")
            nama.text = data?.letterSubject?.htmlToString

//            let pesan = cell.Label(3)
            let jam = cell.Label(4)
            jam.text = data?.postedAt
            let dispo = cell.Label(5)
            if data?.isDisposition == true {
                dispo.isHidden = false
            }else {
                dispo.isHidden = true
            }
    
            dispo.makeRoundedRect(withCornerRadius: 5)
            return cell
//        case(0, 2):
//            let cell = tableView.cell("message")!
//            let photo = cell.Label(1)
//            photo.text = "SM"
//            photo.makeRounded()
//            photo.backgroundColor = UIColor.red
//
//            let nama = cell.Label(2)
//            nama.text = "Undangan Workshop"
//
//            //            let pesan = cell.Label(3)
//            //            let jam = cell.Label(4)
//            let dispo = cell.Label(5)
//            dispo.makeRoundedRect(withCornerRadius: 5)
//            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let data = listInbox?[indexPath.row - 1]
        let vc = UIViewController.instantiate(named: "InboxDetailVc") as? InboxDetailVc
        vc?.show(currentVc: self, letterType: data?.letterType, letterNumber: data?.letterNumber, letterDate: data?.postedAt, sender: data?.sender, letterCharacter: data?.letterCharacter, letterSubject: data?.letterSubject, file: data?.file, isActionable: data?.isActionable, isDisposition: data?.isDisposition)
        
    }
}
