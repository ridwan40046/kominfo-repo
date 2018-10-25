//
//  IsiVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Asad Ardiansyah on 25/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

class IsiVc: BaseVc {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}

extension IsiVc: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, cellForRowAt: indexPath).height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.cell("judul")!
            return cell
        case 1:
            let cell = tableView.cell("isi")!
            cell.Label(1).text = "dari tanggal"
            cell.Label(2).text = "Oktober 27 2018 (13:00)"
            cell.Label(3).isHidden = true
            return cell
        case 2:
            let cell = tableView.cell("isi")!
            cell.Label(1).text = "sampai tanggal"
            cell.Label(2).text = "Oktober 27 2018 (16:00)"
            cell.Label(3).isHidden = true
            return cell
        case 3:
            let cell = tableView.cell("isi")!
            cell.Label(1).text = "pengirim"
            cell.Label(2).text = "Sekjen Kominfo"
            cell.Label(3).isHidden = true
            return cell
        case 4:
            let cell = tableView.cell("isi")!
            cell.Label(1).text = "alamat"
            cell.Label(2).text = "Auditorium Pusat"
            cell.Label(3).isHidden = true
            return cell
        case 5:
            let cell = tableView.cell("isi")!
            cell.Label(1).text = "lampiran"
            cell.Label(2).text = "Nama File"
            cell.Label(3).isHidden = false
            cell.Label(3).makeRoundedRect(withCornerRadius: 5)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}
