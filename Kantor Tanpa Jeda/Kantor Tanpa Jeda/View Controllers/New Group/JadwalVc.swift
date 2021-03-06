//
//  JadwalVc.swift
//  Kantor Tanpa Jeda
//
//  Created by Asad Ardiansyah on 11/10/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//

import Foundation
import CalendarLib

class JadwalVc: BaseVc {
    var dataAgendas: AgendasObj?
    var events = [EventObj]()
    var viewR = UIView()
    var currentVc: UIViewController?
    let today = Date()
    let year = Calendar.current.component(.year, from: Date())
    let month = Calendar.current.component(.month, from: Date())
    var isHidden = false
    
    @IBOutlet var viewPicker: UIView!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var monthView: MGCMonthPlannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEvent()
        setCalendarAttr()
        reloadData()
    }
    @IBAction func btnCancelTapped(_ sender: UIButton) {
        viewPicker.removeFromSuperview()
    }
    @IBAction func btnDoneTapped(_ sender: UIButton) {
        viewPicker.removeFromSuperview()
    }
    
    @IBAction func btnTambahTapped(_ sender: UIButton) {
        let vc = UIViewController.instantiate(named: "NewAgendaVc") as? NewAgendaVc
        vc?.show(currentVc: self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        btnPlus.isHidden = isHidden

        setHeader()
        setNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setCustomCalendar()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewR.removeFromSuperview()
        self.tabBarController?.tabBar.isHidden = false
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = false
        } else {
            // Fallback on earlier versions
        }
    }
    
    func show(currentVc: UIViewController, title: String, isHidden: Bool) {
        self.currentVc = currentVc
        self.title = title
        self.isHidden = isHidden
        currentVc.navigationController?.pushViewController(self, animated: true)
    }
    
    func reloadData(){
        let calendar = Calendar.current
        let start = DateComponents(calendar: calendar, year: year, month: month, day: 1, hour: 7, minute: 0, second: 0)
        let end = DateComponents(calendar: calendar, year: year, month: month + 1, day: 1, hour: 7, minute: 0, second: 0)
        Engine.getHeadAgenda(start: calendar.date(from: start)!, end: calendar.date(from: end)!){
            self.dataAgendas = $0?.headAgenda
        }
    }
    
    override func setNavBar(){
        

        let back = UIBarButtonItem()
        back.title = "Kembali"
        currentVc?.navigationItem.backBarButtonItem = back
        let btnKanan = UIBarButtonItem(image: UIImage(named: "hamburger.png")?.resize(20, 20), style: .done, target: self, action: #selector(hamburger))
        
        let btnFilter = UIBarButtonItem(image: UIImage(named: "Filter.png")?.resize(18, 18), style: .done, target: self, action: #selector(filter))
        
        self.navigationItem.setRightBarButtonItems([btnKanan, btnFilter], animated: false)
    }
    
    @objc func filter(){
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
//            if string.trimmingCharacters(in: .whitespaces) != "" {
//                self.selectedMonth = "\(arrBulan[month-1]) \(year)"
//            }
        }
    }
    func setEvent() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let event1 = EventObj.init(title: "Jalan Santai", subtitle: "Hut RI", start: formatter.date(from: "01-10-2018 07:00:00")!, end: formatter.date(from: "01-10-2018 13:00:00")!)
        let event2 = EventObj.init(title: "Rapat", subtitle: "Kominfo", start: formatter.date(from: "01-10-2018 08:00:00")!, end: formatter.date(from: "01-10-2018 10:00:00")!)
        let event3 = EventObj.init(title: "Monev", subtitle: "Dikti", start: formatter.date(from: "06-10-2018 10:00:00")!, end: formatter.date(from: "08-10-2018 15:00:00")!)
        let event4 = EventObj.init(title: "Team Lunch", subtitle: "Internal", start: formatter.date(from: "07-10-2018 08:00:00")!, end: formatter.date(from: "08-10-2018 11:00:00")!)
        events.removeAll()
        events = [event1, event2, event3, event4]
    }
    
    func getRandomColor() -> UIColor {
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
    func filterEvent(date: Date) -> [EventObj]{
        var arr = [EventObj]()
        for event in events {
            if Calendar.current.isDate(event.start, inSameDayAs: date){
                arr.append(event)
            }
        }
        return arr
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
    
    func setCustomCalendar(){
        let v = monthView.subviews
        let day = Calendar.current.component(.day, from: Date())
        var c: UICollectionView?
        for subv in v {
            if let col = subv as? UICollectionView {
                c = col
            }
        }
        if let subs = c?.subviews {
            
            for i in 0..<subs.count {
                if let cell = subs[i] as? UICollectionViewCell {
                    let view = cell.subviews[1]
                    let label = view.subviews[0] as? UILabel
                    label?.text = "\(i+1)"
                    label?.textAlignment = .center
                    label?.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 0.4))
                    label?.height = view.height - 30
                    
                    let lblCountEvent = UILabel(frame: view.bounds)
                    lblCountEvent.height = 20
                    lblCountEvent.center.y = view.centerY + 15
                    lblCountEvent.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight(rawValue: 0.1))
                    lblCountEvent.textAlignment = .center
                    lblCountEvent.text = "\(i+1)"
                    view.addSubview(lblCountEvent)
                    
                    
                    let components = DateComponents(year: year, month: month, day: i+1)
                    let allDay = Calendar.current.date(from: components)!
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "ccc"
                    
                    let Monday = dateFormatter.string(from: allDay)
                    
                    if Monday == "Sun" {
                        label?.textColor = .red
                    }
                }
            }
            
            //get today's label
            let highlightV = subs[day-1].subviews[1] //cellItem
            let max = highlightV.frame.width > highlightV.frame.height ? highlightV.frame.height : highlightV.frame.width
            let bgView = UIView(frame: highlightV.bounds)
            bgView.frame.size = CGSize(width: max, height: max)
            bgView.center = highlightV.center
            bgView.backgroundColor = .orangeCalendar
            bgView.layer.cornerRadius = max / 3.5
            
            
            
            
            highlightV.traverseLabel(){ lbl in
                lbl.textColor = .white
            } //label
            
//            lblToday.frame.size = CGSize(width: max, height: max)
//            lblToday.center = highlightV.center
//
//            //backround label = orange, set corner radius
//            lblToday.backgroundColor = UIColor.orangeCalendar
//            lblToday.clipsToBounds = true
//
//            lblToday.layer.cornerRadius = max / 3.5
            highlightV.insertSubview(bgView, at: 0)
        }
    }
    
    func setCalendarAttr(){
        monthView.delegate = self
        monthView.dataSource = self
        monthView.dateFormat = "dd"
        monthView.gridStyle = .horizontalLines
        monthView.pagingMode = .none
        monthView.weekdaysLabelFont = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 0.4))
        monthView.monthInsets = UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0)
        monthView.itemHeight = 0
        monthView.rowHeight = 75
        monthView.dayCellHeaderHeight = monthView.rowHeight
        monthView.weekendDayBackgroundColor = .white
        monthView.weekDaysStringArray = ["S","M","T","W","T","F","S"]
        monthView.calendar.firstWeekday = 2
        monthView.headerHeight = 0
        
        
        let calendar = Calendar.current
        let start = DateComponents(calendar: calendar, year: year, month: month, day: 1, hour: 7, minute: 0, second: 0)
        let end = DateComponents(calendar: calendar, year: year, month: month + 1, day: 1, hour: 7, minute: 0, second: 0)
        
        monthView.dateRange = MGCDateRange(start: calendar.date(from: start), end: calendar.date(from: end))
        
    }
}

extension JadwalVc: MGCMonthPlannerViewDelegate, MGCMonthPlannerViewDataSource {
    func monthPlannerView(_ view: MGCMonthPlannerView!, didSelectEventAt index: UInt, date: Date!) {
        print("ini event", date, index)
    }
    func monthPlannerView(_ view: MGCMonthPlannerView!, didSelectDayCellAt date: Date!) {
        print(date)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Calendar", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ListEventVc") as! ListEventVc
        viewController.show(event: filterEvent(date: date), date: date, currentVc: self, isHidden: isHidden)
    }
    
    func monthPlannerView(_ view: MGCMonthPlannerView!, numberOfEventsAt date: Date!) -> Int {
        var count = 0
        for event in events {
            if Calendar.current.isDate(event.start, inSameDayAs: date){
                count += 1
            }
        }
        return count
    }
    
    func monthPlannerView(_ view: MGCMonthPlannerView!, dateRangeForEventAt index: UInt, date: Date!) -> MGCDateRange! {
        //        let start = Date()
        //        let end = start.addingTimeInterval(24*3600)
        //        return MGCDateRange.init(start: start, end: end)
        let idx = Int(index)
        let event = filterEvent(date: date)
        return MGCDateRange.init(start: event[idx].start, end: event[idx].end)
    }
    
    func monthPlannerView(_ view: MGCMonthPlannerView!, cellForEventAt index: UInt, date: Date!) -> MGCEventView! {
        let idx = Int(index)
        let event = filterEvent(date: date)[idx]
        let eventView = MGCStandardEventView()
        eventView.title = event.title
        eventView.subtitle = event.subtitle
        eventView.style = [.dot]
        eventView.color = getRandomColor()
        return eventView
    }
    
}
