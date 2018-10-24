//
//  InfoVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Ridwan Surya Putra on 10/18/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

class InfoVc: BaseVc {
    
    @IBOutlet var tv: UITableView!
    
    var labelNama = [
        "Johnny Padilla",
        "Leon Armstrong",
        "Warren Chavez",
        "Ernest Perez",
        "Lucas Gonzalez",
        "Johnny Padilla",
        "Leon Armstrong",
        "Warren Chavez",
        "Ernest Perez",
        "Lucas Gonzalez"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
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
    override func setNavBar() {
        super.setNavBar()
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        
    }

}

extension InfoVc: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, cellForRowAt: indexPath).height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell()
        let nama = labelNama[indexPath.row]
        let judul = cell?.label(2)
        judul?.text = nama
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let vc = UIViewController.instantiate(named: "InfoDetailVc") as? InfoDetailVc
        vc?.show(currentVc: self)
    }
}
