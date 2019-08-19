# AASlidingTopTabBar


![AASlidingTopTabBar first tab selected] (https://imgur.com/SyPGxld)  
![AASlidingTopTabBar tab transitions] (https://imgur.com/rjQ6im7)  
![AASlidingTopTabBar third tab selected] (https://imgur.com/yUeAyOO)

![Demo of AASlidingTopTabBar] (https://imgur.com/J5fXJp7)  

AASlidingTopTabBar allows you to create a UITabBar with tabs on top of screen like android tab controller. AASlidingTopTabBar is purely written in swift and has following features.

# Features:
1) Highly customizable.
2) Installation using pod

# How to use 


In your ViewController.swift where you want to add tab bar, please add below code 

```
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
        vc.titleLetterSpacing = 1.0
        vc.initialSelectedTabIndex = 1
        vc.initWithViewController(controllers: controllerArray, parentViewController: self, forHeight: 40.0)
        self.view.addSubview(vc.view)
    }
  }
```

<b>Get notified when a tab has been changed by user:</b> 

```
 //MARK:- AASlidingTabBarControllerDelegate
    func currentSelectedIndex(_ index: Int) {
        print("Selcted tab index = \(index)")
    }
```

# The MIT License (MIT)

Copyright (c) 2019-present Aman Aggarwal

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
