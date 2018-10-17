//
//  DaftarVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Ridwan Surya Putra on 10/13/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit
import Dropdowns

class DaftarVc: UIViewController {
    @IBOutlet var tv : UITableView!
    var currentVc: UIViewController?;
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBar()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func show(currentVc: UIViewController){
        currentVc.navigationController?.pushViewController(self, animated: true);
    }
    @IBAction func register(){
        let vc = UIViewController.instantiate(named: "LoginVc") as? LoginVc
        vc?.show(from: self)
    }
    func setNavBar(){
        let back = UIBarButtonItem()
        back.title = "Kembali"
        currentVc?.navigationItem.backBarButtonItem = back
        let btnSimpan = UIBarButtonItem(title: "Simpan", style: .done, target: self, action: #selector(register))
        
        self.navigationItem.setRightBarButtonItems([btnSimpan], animated: false)
    }
}

extension DaftarVc : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.cell("cell")
            let title = cell?.label(1)
           // let content = cell?.textField(2)
            title?.text = "Username"
            return cell!
        case 1:
            let cell = tableView.cell("cell")
            let title = cell?.label(1)
            // let content = cell?.textField(2)
            title?.text = "Email"
            return cell!
//        case 2:
//            let cell = tableView.cell("cell")
//            let title = cell?.label(1)
//            // let content = cell?.textField(2)
//            title?.text = "Email"
//            return cell!
//        case 3:
//            let cell = tableView.cell("cell1")
//            let title = cell?.label(1)
//            // let content = cell?.textField(2)
//            title?.text = "Satuan Kerja"
//            return cell!
//        case 4:
//            let cell = tableView.cell("cell1")
//            let title = cell?.label(1)
//            // let content = cell?.textField(2)
//            title?.text = "Jabatan"
//            return cell!
//        case 5:
//            let cell = tableView.cell("cell1")
//            let title = cell?.label(1)
//            // let content = cell?.textField(2)
//            title?.text = "Status Pegawai"
//            return cell!
        default: break
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return self.tableView(tableView, cellForRowAt: indexPath).height
    }
}
