//
//  DisposisiVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Asad Ardiansyah on 22/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

class DisposisiVc: BaseVc {
    
    @IBOutlet weak var tblView: UITableView!
    var isDiperhatikan = false {didSet{tblView.reloadData()}}
    var isDiagendakan = false {didSet{tblView.reloadData()}}
    var isMessageShown = false
    var lblDiperhatikan: UILabel?
    var lblDiagendakan: UILabel?
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
    
    func show(currentVc: UIViewController, isMessageShown: Bool){
        currentVc.navigationController?.pushViewController(self, animated: true)
        self.currentBaseVc = currentVc
        self.isMessageShown = isMessageShown
    }
    
    override func setNavBar() {
        let back = UIBarButtonItem()
        back.title = "Kembali"
        self.currentBaseVc?.navigationItem.backBarButtonItem = back
        let btnKanan = UIBarButtonItem(image: UIImage(named: "hamburger.png")?.resize(20, 20), style: .done, target: self, action: #selector(hamburger))
        
        let btnFilter = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: nil)
        
        self.navigationItem.setRightBarButtonItems([btnKanan, btnFilter], animated: false)
    }
    
    @IBAction func btnAddKepadaTapped(_ sender: UIButton) {
        let vc = UIViewController.instantiate(named: "KepadaVc") as? KepadaVc
        vc?.show(currentVc: self)
    }
    
    @IBAction func btnAddArahanTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Diagendakan", comment: "Default action"), style: .default, handler: { res in
            self.isDiagendakan = !(self.isDiagendakan)
        }))
        alert.addAction(UIAlertAction(title: "Diperhatikan", style: .default, handler: { res in
            self.isDiperhatikan = !(self.isDiperhatikan)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { res in
            toast("Cancel")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension DisposisiVc: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !isMessageShown, indexPath.row < 2 {
            return 0
        }
        return self.tableView(tableView, cellForRowAt: indexPath).height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.cell("disposisi")!
            let backgroundView = cell.View(1)
            backgroundView.makeRoundedRect(withCornerRadius: 10)
            return cell
        case 1:
            let cell = tableView.cell("header")!
            return cell
        case 2:
            let cell = tableView.cell("kepada")!
            cell.View(666).height = 0.5
            return cell
        case 3:
            let cell = tableView.cell("arahan")!
            let diperhatikan = cell.Label(1)
            lblDiperhatikan = diperhatikan
            diperhatikan.makeRoundedRect(withCornerRadius: diperhatikan.height / 2)
            
            let diagendakan = cell.Label(2)
            lblDiagendakan = diagendakan
            diagendakan.makeRoundedRect(withCornerRadius: diagendakan.height / 2)
            
            diperhatikan.isHidden = !(isDiperhatikan)
            diagendakan.isHidden = !(isDiagendakan)
            
            if isDiperhatikan {
                if isDiagendakan {
                    diagendakan.x = diperhatikan.right + 8
                }
            }
            else {
                if isDiagendakan {
                    diagendakan.x = 82
                }
            }
            
            cell.View(666).height = 0.5
            return cell
        case 4:
            let cell = tableView.cell("isi")!
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}
