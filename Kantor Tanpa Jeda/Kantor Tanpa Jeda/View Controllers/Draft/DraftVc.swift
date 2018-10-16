//
//  DraftVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Asad Ardiansyah on 17/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import UIKit

class DraftVc: BaseVc {
    var labelCollection = [
        "Undangan",
        "Nota Dinas",
        "Surat Tugas",
        "Surat Dinas",
        "Surat Cuti",
        "Lupa Absen",
        "Undangan",
        "Nota Dinas",
        "Surat Tugas",
        "Surat Dinas",
        "Surat Cuti"
    ]
    
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
    
    var selectedColIndex = 0 {
        didSet{
            tblView.reloadData()
        }
    }
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var colView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let a = "halo selamat pagi"
        let b = a[1]
        let c = String(b)
        print(b)
        print(c)
    }
    
    var colorArr = [UIColor]() {
        didSet{
            tblView.reloadData()
        }
    }
}

extension DraftVc: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colorArr.removeAll()
        for _ in 0..<10 {
            colorArr.append(UIColor.getRandomColor())
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedColIndex = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell("cellItem", indexPath: indexPath)!
        let txt = labelCollection[indexPath.row]
        
        let inisial = txt.getInisial()
        
        let lingkaran = cell.Label(1)
        lingkaran.backgroundColor = colorArr[indexPath.row]
        lingkaran.makeRounded()
        lingkaran.text = inisial
        
        
        let label = cell.Label(2)
        label.text = labelCollection[indexPath.row]
        return cell
    }
}

extension DraftVc: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, cellForRowAt: indexPath).height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell("cell")!
        let nama = labelNama[indexPath.row]
        let lingkaran = cell.Label(1)
        lingkaran.makeRounded()
        lingkaran.text = nama.getInisial()
        
        lingkaran.backgroundColor = colorArr[safe: selectedColIndex]
        
        let judul = cell.Label(2)
        judul.text = nama
        
//        let isi = cell.Label(3)
        return cell
    }
    
    
}
