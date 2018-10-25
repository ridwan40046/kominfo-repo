//
//  KepadaVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Asad Ardiansyah on 22/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit
class KepadaVc: BaseVc {
    var checkList = [false, false, false, false, false]
    @IBOutlet weak var searchView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.makeRoundedRect(withCornerRadius: 10)
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
        let back = UIBarButtonItem()
        back.title = "Kembali"
        self.currentBaseVc?.navigationItem.backBarButtonItem = back
        let btnKanan = UIBarButtonItem(image: UIImage(named: "hamburger.png")?.resize(20, 20), style: .done, target: self, action: #selector(hamburger))
        
        let btnPilih = UIBarButtonItem(title: "Pilih", style: .done, target: self, action: nil)
        
        self.navigationItem.setRightBarButtonItems([btnKanan, btnPilih], animated: false)
    }
}
extension KepadaVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, cellForRowAt: indexPath).height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell("cell")!
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let cell = tableView.cellForRow(at: indexPath)
        guard let img = cell?.Image(3) else {return}
//        img.isHidden = !img.isHidden
        checkList[indexPath.row] = !(checkList[indexPath.row])
        cell?.accessoryType = checkList[indexPath.row] ? .checkmark : .none
    }
    
}
