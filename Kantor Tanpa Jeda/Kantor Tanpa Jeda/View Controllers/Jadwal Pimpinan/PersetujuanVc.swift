//
//  PersetujuanVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Asad Ardiansyah on 13/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

class PersetujuanVc: BaseVc {
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
    
    override func setNavBar() {
        super.setNavBar()
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        
    }
}

extension PersetujuanVc: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, cellForRowAt: indexPath).height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell("cell")!
        let marker = cell.Label(4)
        marker.isHidden = false
        marker.makeRoundedRect(withCornerRadius: 5)
        if indexPath.row == 1 {
            marker.text = "Disetujui"
            marker.backgroundColor = .green
        }
        else if indexPath.row == 4 {
            marker.text = "Ditolak"
            marker.backgroundColor = .red
        }
        else {
            marker.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let vc = UIViewController.instantiate(named: "InfoJadwalVc") as? InfoJadwalVc
        
        vc?.view.frame = self.view.bounds
        let v = vc?.view
        
        UIApplication.shared.keyWindow?.addSubview(v!)
        self.addChildViewController(vc!)
        self.didMove(toParentViewController: self)
        let lbl = vc?.lblSetuju
        let viewBtn = vc?.viewButton
        
        if indexPath.row == 1 {
            viewBtn?.isHidden = true
            lbl?.isHidden = false
            lbl?.text = "DISETUJUI"
            lbl?.backgroundColor = .green
        }
        else if indexPath.row == 4 {
            viewBtn?.isHidden = true
            lbl?.isHidden = false
            lbl?.text = "DITOLAK"
            lbl?.backgroundColor = .red
        }
        else {
            viewBtn?.isHidden = false
            lbl?.isHidden = true
        }
    }
    
}
