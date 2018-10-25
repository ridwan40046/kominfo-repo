//
//  ListEventVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Asad Ardiansyah on 11/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import CalendarLib

class ListEventVc: BaseVc {
    @IBOutlet weak var dayPlannerView: MGCDayPlannerView!
    var viewR = UIView()
    @IBOutlet var viewHeader: UIView!
    var lblTitle = UILabel()
    var selectedMonth = ""
    var events = [EventObj]()
    var date: Date?
    var currentVc: UIViewController?
    var isHidden = false
 
    @IBOutlet var viewFilter: UIView!
    @IBOutlet weak var lblHari: UILabel!
    @IBOutlet weak var miniCalView: UIView!
    @IBOutlet weak var btnPlus: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setListAtt()
        lblHari.text = self.date?.stringOfDate
        let df = DateFormatter()
        df.dateFormat = "MMMM yyyy"
        selectedMonth = df.string(from: date!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBar()
        setHeader()
        setCalendarMini()
        btnPlus.isHidden = isHidden
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        viewR.removeFromSuperview()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func btnTambahTapped(_ sender: UIButton) {
        let vc = UIViewController.instantiate(named: "NewAgendaVc") as? NewAgendaVc
        vc?.show(currentVc: self)
    }
    
    func setListAtt(){
        dayPlannerView.numberOfVisibleDays = 1
        dayPlannerView.delegate = self
        dayPlannerView.dataSource = self
        dayPlannerView.dayHeaderHeight = 0
        
        
        dayPlannerView.hourSlotHeight = 50
        dayPlannerView.showsAllDayEvents = false
        dayPlannerView.dateRange = MGCDateRange(start: date, end: date?.addingTimeInterval(24*3600))
    }
    
    func show(event: [EventObj], date: Date, currentVc: UIViewController, isHidden: Bool){
        self.events = event
        self.date = date
        
        self.currentVc = currentVc
        self.isHidden = isHidden
        currentVc.navigationController?.pushViewController(self, animated: true)
    }
    
    @IBAction func btnOKTapped(_ sender: UIButton) {
        if sender.superview?.superview == viewPicker {
            lblTitle.text = selectedMonth
            viewPicker.removeFromSuperview()
        }
        else {
            viewFilter.removeFromSuperview()
        }

    }
    
    @IBOutlet var viewPicker: UIView!
    @IBAction func btnHeaderTapped(_ sender: UIButton) {
        let vPicker = self.viewPicker
        vPicker?.frame = CGRect(x: 0, y: 66, width: UIScreen.main.bounds.width, height: 200)
        viewPicker.bottom = UIScreen.main.bounds.height
        self.view.addSubview(vPicker!)
        
        let solidView = vPicker?.View(200)
        let containerV = solidView?.View(201)
        let mp = MonthYearPickerView()
        mp.backgroundColor = .white
        mp.frame = containerV!.layer.bounds
        containerV?.addSubview(mp)
        mp.months = arrBulan
        
        mp.onDateSelected = {(month: Int, year: Int) in
            let string = String(format: "%02d/%d", month, year)
            print(string) // should show something like 05/2015
            if string.trimmingCharacters(in: .whitespaces) != "" {
                self.selectedMonth = "\(arrBulan[month-1]) \(year)"
            }
        }
    }
    
    @objc func filter() {
        let vFilter = self.viewFilter
        vFilter?.frame = CGRect(x: 0, y: 66, width: UIScreen.main.bounds.width, height: 200)
        viewFilter.bottom = UIScreen.main.bounds.height
        self.view.addSubview(vFilter!)
    }
    
    func setHeader(){
        let bounds = self.navigationController!.navigationBar.bounds
        let widthScreen = UIScreen.main.bounds.width - 16 //left:8, right:8
        
        let labelWidth = widthScreen / 7
        let labelHeight: CGFloat = 25
        
        let frameR = CGRect(x: 0, y: bounds.height, width: widthScreen + 16, height: labelHeight + 2)
        let frameBorder = CGRect(x: 0, y: labelHeight + 1.5, width: widthScreen, height: 0.5)
        viewR = UIView(frame: frameR)
        
        let gray = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        let darkGray = UIColor(red: 209/255, green: 209/255, blue: 209/255, alpha: 1)
        viewR.backgroundColor = gray
        
        let viewBorder = UIView(frame: frameBorder)
        viewBorder.backgroundColor = darkGray
        
        
        let arr = ["M","T","W","T","F","S","S"]
        for i in 0..<7 {
            let fr = CGRect(x: (CGFloat(i)*labelWidth) + 8, y: 1, width: labelWidth, height: 20)
            let label = UILabel(frame: fr)
            label.text = arr[i]
            label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight(rawValue: 0.3))
            label.textAlignment = .center
            viewR.addSubview(label)
            viewR.addSubview(viewBorder)
        }
        self.navigationController?.navigationBar.addSubview(viewR)
    }
    
    @IBAction func btnCancelTapped(_ sender: UIButton) {
        viewPicker.removeFromSuperview()
        viewFilter.removeFromSuperview()
    }
    
    override func setNavBar(){
        let vHeader = viewHeader
        vHeader?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.5, height: 44)
        lblTitle = vHeader!.Label(111)
        lblTitle.text = selectedMonth
        
        self.navigationItem.titleView = vHeader
        
        
        let back = UIBarButtonItem()
        back.title = "Kembali"
        
        currentVc?.navigationItem.backBarButtonItem = back
        let btnKanan = UIBarButtonItem(image: UIImage(named: "hamburger.png")?.resize(20, 20), style: .done, target: self, action: #selector(hamburger))
        
        let btnFilter = UIBarButtonItem(image: UIImage(named: "Filter.png")?.resize(18, 18), style: .done, target: self, action: #selector(filter))
        
        self.navigationItem.setRightBarButtonItems([btnKanan, btnFilter], animated: false)
    }
    
    
    
    func getRandomColor() -> UIColor {
        //Generate between 0 to 1
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
}

extension ListEventVc: MGCDayPlannerViewDelegate, MGCDayPlannerViewDataSource {
    func dayPlannerView(_ view: MGCDayPlannerView!, numberOfEventsOf type: MGCEventType, at date: Date!) -> Int {
        return events.count
    }
    
    func dayPlannerView(_ view: MGCDayPlannerView!, viewForEventOf type: MGCEventType, at index: UInt, date: Date!) -> MGCEventView! {
        let idx = Int(index)
        let event = events[idx]
        let eventView = MGCStandardEventView()
        eventView.title = event.title
        eventView.subtitle = event.subtitle
        eventView.style = [.plain, .border, .subtitle]
        eventView.color = getRandomColor()
        return eventView
    }
    
    func dayPlannerView(_ view: MGCDayPlannerView!, dateRangeForEventOf type: MGCEventType, at index: UInt, date: Date!) -> MGCDateRange! {
        let idx = Int(index)
        let event = events[idx]
        return MGCDateRange(start: event.start, end: event.end)
    }
    func dayPlannerView(_ view: MGCDayPlannerView!, didSelectEventOf type: MGCEventType, at index: UInt, date: Date!) {
        let vc = UIViewController.instantiate(named: "IsiVc") as? IsiVc
        vc?.show(currentVc: self)
    }
}
