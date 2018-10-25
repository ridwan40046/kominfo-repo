//
//  ProfileVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Ridwan Surya Putra on 10/12/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import UIKit

class ProfileVc: BaseVc {

    @IBOutlet weak var jabatan: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var btnStatusJabatan: UIButton!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var btnDownload: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func edit(){
        
    }
    override func setNavBar() {
        let btnKanan = UIBarButtonItem(image: UIImage(named: "hamburger.png")?.resize(20, 20), style: .done, target: self, action: #selector(edit))
        
        let btnEdit = UIBarButtonItem(image: UIImage(named: "Edit.png")?.resize(18, 18), style: .done, target: self, action: #selector(edit))
        self.navigationItem.setRightBarButtonItems([btnKanan,btnEdit], animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @IBAction func btnStatusTapped(_ sender: Any) {
    }
    @IBAction func btnDownloadTapped(_ sender: UIButton) {
        let vc = UIViewController.instantiate(named: "PasscodeVc") as? PasscodeVc
        vc?.show(from: self)
    }
    
}

extension ProfileVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.cell()
            let title = cell?.label(1)
            let isi = cell?.label(2)
            title?.text = "Jenis Kelamin"
            isi?.text = "Laki - Laki"
            return cell!
        case 1:
            let cell = tableView.cell()
            let title = cell?.label(1)
            let isi = cell?.label(2)
            title?.text = "Status Pegawai"
            isi?.text = "Pegawai Negeri Sipil"
            return cell!
        case 2:
            let cell = tableView.cell()
            let title = cell?.label(1)
            let isi = cell?.label(2)
            title?.text = "NIP"
            isi?.text = "1242536346"
            return cell!
        case 3:
            let cell = tableView.cell()
            let title = cell?.label(1)
            let isi = cell?.label(2)
            title?.text = "NIK"
            isi?.text = "253547433566"
            return cell!
        case 4:
            let cell = tableView.cell()
            let title = cell?.label(1)
            let isi = cell?.label(2)
            title?.text = "No. Handphone"
            isi?.text = "09264729583"
            return cell!
        case 5:
            let cell = tableView.cell()
            let title = cell?.label(1)
            let isi = cell?.label(2)
            title?.text = "Alamat"
            isi?.text = "Jl.Celebration Boulevard Blok AA 09 No 10 - Grand Wisata Bekasi "
            return cell!
        case 6:
            let cell = tableView.cell()
            let title = cell?.label(1)
            let isi = cell?.label(2)
            title?.text = "email"
            isi?.text = "email@gmail.com"
            return cell!
        case 7:
            let cell = tableView.cell()
            let title = cell?.label(1)
            let isi = cell?.label(2)
            title?.text = "Tanggal Lahir"
            isi?.text = "20 Juni 1986"
            return cell!
        case 8:
            let cell = tableView.cell("cell1")
            let title = cell?.label(1)
            let isi = cell?.label(2)
            title?.text = "P 12"
            isi?.text = "Nama File"
            return cell!
        default: break;
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, cellForRowAt: indexPath).height
    }
}
