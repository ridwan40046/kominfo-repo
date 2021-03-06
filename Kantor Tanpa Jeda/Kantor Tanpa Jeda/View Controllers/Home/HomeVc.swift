//
//  HomeVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Ridwan Surya Putra on 10/11/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

class HomeVc: BaseVc {
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var jabatan: UILabel!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var lblView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        engine.me(){
            if $0?.isSuccess ?? false {
                print("nama \($0?.userDetail?.name)")
                self.name.text = $0?.userDetail?.name
                self.jabatan.text = $0?.userDetail?.position
            }
        }

        menu()
        self.navigationItem.title = "Kantor Tanpa Jeda"
        imageProfile.makeRounded()
  
    }
    
}

extension HomeVc{
    func menu(){
        let menuButton = UIBarButtonItem.init(image: UIImage(named: "hambuegr menu.png")?.resize(22, 22), style: .plain, target: self, action: #selector(menuTapped))
        menuButton.tintColor = UIColor.blueButton
        self.navigationItem.rightBarButtonItem = menuButton;
    }
    @objc func menuTapped(){
        
    }
}
extension HomeVc: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0...5: return 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.cell("0-0")
            let lblView = cell?.view(1)
            let label = cell?.label(2)
            label?.text = "2"
            lblView?.makeRounded()
            lblView?.layer.borderWidth = 1
            lblView?.layer.borderColor = UIColor.white.cgColor
            return cell!
        case 1:
            let cell = tableView.cell("1-0")
            return cell!
        case 2:
            let cell = tableView.cell("2-0")
            return cell!
        case 3:
            let cell = tableView.cell("3-0")
            return cell!
        case 4:
            let cell = tableView.cell("4-0")
            return cell!
        case 5:
            let cell = tableView.cell("5-0")
            return cell!
        default: break;
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, cellForRowAt: indexPath).height;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath:    IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch indexPath.section {
        case 0:
            let vc = UIViewController.instantiate(named: "InboxVc") as? InboxVc
            vc?.show(currentVc: self)
        case 1:
            let vc = UIViewController.instantiate(named: "DraftVc") as? DraftVc
            vc?.show(currentVc: self)
        case 2:
            let vc = UIViewController.instantiate(named: "JadwalVc") as? JadwalVc
            vc?.show(currentVc: self, title: "Agenda Pimpinan", isHidden: false)
        case 3:
            let vc = UIViewController.instantiate(named: "PersetujuanVc") as? PersetujuanVc
            vc?.show(currentVc: self)
        case 4:
            let vc = UIViewController.instantiate(named: "JadwalVc") as? JadwalVc
            vc?.show(currentVc: self, title: "Agenda", isHidden: true)
        case 5:
            let vc = UIViewController.instantiate(named: "InfoVc") as? InfoVc
            vc?.show(currentVc: self)
            
        default:
            print("\(indexPath.section), \(indexPath.row)")
        }
    }
}
