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
    @IBOutlet var viewTolak: UIView!
    @IBOutlet var viewSetuju: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true

    }
    
    @IBAction func btnDismissTapped() {
        self.view.endEditing(true);
        let shade = self.view.view(12345);
        let view = self.view.view(23456);
        UIView.animate(withDuration: 0.3, animations: {
            shade?.alpha = 0;
            view?.alpha = 0;
        }) { (done) in
            shade?.removeFromSuperview();
            view?.removeFromSuperview();
        }
    }
    
    func openPopup(_ view: UIView) {
        self.view.endEditing(true);
        var shade : UIView! = self.view.view(12345);
        if shade == nil {
            shade = UIView.init(frame: UIScreen.main.bounds);
            shade.backgroundColor = UIColor.black;
            shade.alpha = 0;
            shade.tag = 12345;
            shade.addTapGestureRecognizer(self, action: #selector(btnDismissTapped));
            self.view.addSubview(shade);
        }
        
        let oldPopup : UIView? = self.view.view(23456);
        if oldPopup == nil {
            view.tag = 23456;
            self.view.addSubview(view);
            UIView.animate(withDuration: 0.3) {
                shade.alpha = 0.75;
                view.alpha = 1;
            }
        }
        else {
            UIView.animate(withDuration: 0.3, animations: {
                oldPopup?.alpha = 0;
            }) { (done) in
                oldPopup?.removeFromSuperview();
                view.makeRoundedRect(withCornerRadius: 5);
                view.tag = 23456;
                view.alpha = 0;
                self.view.addSubview(view);
                UIView.animate(withDuration: 0.3) {
                    view.alpha = 1;
                }
            }
        }
        
    }
    
    @IBAction func tolakTapped(_ sender: UIButton){
        self.viewTolak.center = self.view.center
        self.openPopup(self.viewTolak)
    }
    @IBAction func tandaTanganTapped(_ sender: UIButton){
        self.viewSetuju.center = self.view.center
        self.openPopup(self.viewSetuju)
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
