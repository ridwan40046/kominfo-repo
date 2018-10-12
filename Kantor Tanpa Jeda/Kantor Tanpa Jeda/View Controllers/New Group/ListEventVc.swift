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
    
    var events = [EventObj]()
    var date: Date?
    var currentVc: UIViewController?
    var isHidden = false
 
    @IBOutlet weak var btnPlus: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setListAtt()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavBar()
        btnPlus.isHidden = isHidden
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
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
        dayPlannerView.dayHeaderHeight = 30
        
        
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
    
    override func setNavBar(){
        self.title = "Oktober 2018"
        let back = UIBarButtonItem()
        back.title = "Kembali"
        currentVc?.navigationItem.backBarButtonItem = back
        let btnKanan = UIBarButtonItem(image: UIImage(named: "hamburger.png")?.resize(20, 20), style: .done, target: self, action: #selector(hamburger))
        
        let btnFilter = UIBarButtonItem(image: UIImage(named: "Filter.png")?.resize(18, 18), style: .done, target: self, action: nil)
        
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
}
