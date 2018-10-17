//
//  InboxDetailVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Asad Ardiansyah on 13/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

class InboxDetailVc: BaseVc {
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLaporan.makeRoundedRect(withCornerRadius: 5)
        btnDisposisi.makeRoundedRect(withCornerRadius: 5)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    @IBOutlet weak var btnDisposisi: UIButton!
    @IBOutlet weak var btnLaporan: UIButton!
    
    
    @IBAction func laporanTapped(_ sender: UIButton) {
        let vc = UIViewController.instantiate(named: "LaporanVc") as? LaporanVc
        vc?.show(currentVc: self)
    }
    
}

extension InboxDetailVc: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return 1
        }
        else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  self.tableView(tableView, cellForRowAt: indexPath).height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let cell = tableView.cell("header")!
            cell.View(666).makeRoundedRect(withCornerRadius: 10)
            return cell
        case (1, 0):
            let cell = tableView.cell("message")!
            let judul = cell.Label(1)
            judul.textColor = UIColor.blue
            judul.text = "Disposisi"
            
            let tanggal = cell.Label(2)
            tanggal.textColor = UIColor.blue
            
            let view = cell.View(666)
            view.makeRoundedRect(withCornerRadius: 10)
            
            let btnDisposisi = cell.Button(101)
            btnDisposisi.makeRoundedRect(withCornerRadius: 5)
            
            let btnLaporan = cell.Button(102)
            btnLaporan.makeRoundedRect(withCornerRadius: 5)
            return cell
        case (2, 0):
            let cell = tableView.cell("message")!
            let judul = cell.Label(1)
            judul.textColor = UIColor.green
            judul.text = "Komentar"
            
            let tanggal = cell.Label(2)
            tanggal.textColor = UIColor.green
            
            let view = cell.View(666)
            view.makeRoundedRect(withCornerRadius: 10)
            
            let btnDisposisi = cell.Button(101)
            btnDisposisi.makeRoundedRect(withCornerRadius: 5)
            
            let btnLaporan = cell.Button(102)
            btnLaporan.makeRoundedRect(withCornerRadius: 5)
            return cell
            
        case (3, 0):
            let cell = tableView.cell("message")!
            let judul = cell.Label(1)
            judul.textColor = UIColor.red
            judul.text = "Laporan"
            
            let tanggal = cell.Label(2)
            tanggal.textColor = UIColor.red
            
            let view = cell.View(666)
            view.makeRoundedRect(withCornerRadius: 10)
            
            let btnDisposisi = cell.Button(101)
            btnDisposisi.makeRoundedRect(withCornerRadius: 5)
            
            let btnLaporan = cell.Button(102)
            btnLaporan.makeRoundedRect(withCornerRadius: 5)
            return cell
        case (_, 1):
            let cell = tableView.cell("separator")!
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}
