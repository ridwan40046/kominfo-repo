//
//  BaseViewController.swift
//  FamilyTree
//
//  Created by Martin Tjandra on 1/29/18.
//  Copyright © 2018 idesolusiasia. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController : UIViewController {                                                                                       
    
    var animatedDistance: Double = 0;
    var containerVc: UIViewController?;
    var listenerHandlers = [UInt](); // add handlers here to automatically deattach when vc destroyed
    var curFocusedView: UIView?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationController?.navigationBar.barTintColor = UIColor.redTabBar;
//        self.navigationController?.navigationBar.barStyle = UIBarStyle.black;
//        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white];

        self.navigationController?.navigationBar.titleTextAttributes =
            [.foregroundColor: UIColor.white,
             .font: UIFont(name: "Pacifico-regular", size: 21)!]
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Edit", target: self, action: #selector(search(_:)));
        //self.addRightBarButton (title: "Edit", target: self, action: #selector(EditData()));
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.view.traverse { (view) in
            if let tf = view as? UITextField, let superview = tf.superview, tf.tag < 1000 {
                if superview.height - tf.height < 2 {
                    superview.setBorderForForm();
                }
            }
            if let tv = view as? UITextView, let superview = tv.superview {
                if superview.height - tv.height < 2 {
                    superview.setBorderForForm();
                }
            }
            if let btn = view as? UIButton, let superview = btn.superview {
                superview.makeRoundedRect(withCornerRadius: 5);
            }
        }
    }
    @objc func search(_ sender: UIButton?){
        
    }
    func addAutoDismissKeyboard (view: UIView?) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view?.addGestureRecognizer(tap)
    }
    
    func textFieldDone () { // will be called when the user finish input using return key. should be overridden.
        
    }

    func setMainView (_ view: UIView?) {
        guard let view = view else { return; }
        for aView in self.view.subviews { if aView == view { return; } }
        self.view.subviews.forEach({ if $0.y < 100 && $0 != view { $0.alpha = 1; } })
        if self.navigationController != nil, let isHidden = self.navigationController?.isNavigationBarHidden,
            !isHidden {
            view.y = self.navigationController!.navigationBar.bottom;
            view.width = self.view.width;
        }
        self.view.addSubview(view);
        view.alpha = 0;
        UIView.animate(withDuration: 0.3, animations: {
            self.view.subviews.forEach({ if $0.y < 100 && $0 != view { $0.alpha = 0; } })
            view.alpha = 1;
        }) { done in
            self.view.subviews.forEach({ if $0.y < 100 && $0 != view { $0.removeFromSuperview(); } })
        }
    }
    
    func getMainView() -> UIView? {
        for view in self.view.subviews { if view.y < 100 && view.width > 0 && view.height > 0 { return view; } }
        return nil;
    }
    
    var mainView : UIView? {
        set { setMainView(newValue); }
        get { return getMainView(); }
    }
    
    deinit {
    }
    
}
