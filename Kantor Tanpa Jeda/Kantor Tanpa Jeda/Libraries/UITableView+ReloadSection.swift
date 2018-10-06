//
//  UITableView+ReloadSection.swift
//  LearnFlux
//
//  Created by Martin Tjandra on 9/4/17.
//  Copyright © 2017 Martin Darma Kusuma Tjandra. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func reloadSection (_ section: Int?, with: UITableViewRowAnimation = .automatic) {
        guard let section = section else { return; }
        reloadSections(IndexSet(integer: section), with: with);
    }
    
}
