//
//  ViewController.swift
//  AASlidingTopTabBar
//
//  Created by Aman Aggarwal on 14/08/19.
//  Copyright © 2019 Aman Aggarwal. All rights reserved.
//

import UIKit

class ViewController: UIViewController,AASlidingTabControllerDelegate {
    
    var controllerArray = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createTabController()
    }
    
    func createTabController() {
        
        let pendingEventsVC = self.storyboard?.instantiateViewController(withIdentifier: "PendingEventsVC") as! PendingEventsVC
        pendingEventsVC.title = "Pending Events"
        
        let completedEventsVC = self.storyboard?.instantiateViewController(withIdentifier: "CompletedEventsVC") as! CompletedEventsVC
        completedEventsVC.title = "Completed Events"
        
        let cancelledEventsVC = self.storyboard?.instantiateViewController(withIdentifier: "CancelledEventsVC") as! CancelledEventsVC
        cancelledEventsVC.title = "Cancelled Events"
        
        
        controllerArray.append(pendingEventsVC)
        controllerArray.append(completedEventsVC)
        controllerArray.append(cancelledEventsVC)
        
        
        let vc = AASlidingTabController()
        vc.delegate = self
        vc.indicatorTintColor = UIColor(red: 169.0/255.0, green: 1.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        vc.indicatorHeight = 5.0
        vc.selectedTabTitleColor = UIColor(red: 169.0/255.0, green: 1.0/255.0, blue: 25.0/255.0, alpha: 1.0)
        vc.unSelectedTabTitleColor =   UIColor(red: 169.0/255.0, green: 1.0/255.0, blue: 25.0/255.0, alpha: 0.6)
        vc.tabBackgroundColor = .red
        vc.titleLetterSpacing = 1.0
        vc.initialSelectedTabIndex = 1
        vc.initWithViewController(controllers: controllerArray, parentViewController: self, forHeight: 40.0)
        self.view.addSubview(vc.view)
    }
    
    
    //MARK:- AASlidingTabBarControllerDelegate
    func currentSelectedIndex(_ index: Int) {
        print("Selcted tab index = \(index)")
    }
    
    
}

