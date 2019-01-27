//
//  NewAgendaVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Asad Ardiansyah on 12/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

class NewAgendaVc: BaseVc {
    let header = ["Nama Kegiatan", "Waktu Mulai", "Waktu Berhenti", "Alamat", "Tembusan", "File / Dokumen"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}

extension NewAgendaVc: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, cellForRowAt: indexPath).height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (_, 0):
            let cell = tableView.cell("header")!
            let label = cell.Label(1)
            let text = header[indexPath.section]
            label.text = header[indexPath.section]
            return cell
        case (0, _):
            let cell = tableView.cell("standard")!
            return cell
        case (1, _):
            let cell = tableView.cell("dropdown")!
            return cell
        case (2, _):
            let cell = tableView.cell("dropdown")!
            return cell
        case (3, _):
            let cell = tableView.cell("cellLong")!
            return cell
        case (4, _):
            let cell = tableView.cell("dropdown")!
            return cell
        case (5, _):
            let cell = tableView.cell("share")!
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}
