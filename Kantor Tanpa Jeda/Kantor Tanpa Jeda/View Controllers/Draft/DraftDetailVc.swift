//
//  DraftDetailVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Ridwan Surya Putra on 10/25/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

class DraftDetailVc: BaseVc {
    
    @IBOutlet var tv: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true

    }
    
    @IBAction func tolakTapped(_ sender: UIButton){
        
    }
    @IBAction func tandaTanganTapped(_ sender: UIButton){
        
    }
}

extension DraftDetailVc : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell("header")
        cell?.view(666)?.makeRoundedRect(withCornerRadius: 5)
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, cellForRowAt: indexPath).height
    }
}
