//
//  AASlidingTabController.swift
//  AASlidingTabController
//
//  Created by Aman Aggarwal on 2/22/17.
//  Copyright © 2017 ClickApps. All rights reserved.
//
import UIKit

public protocol AASlidingTabControllerDelegate {
    func currentSelectedIndex(_ index: Int)
}

public class AASlidingTabController: UIViewController, UIScrollViewDelegate {
    
    public var delegate:AASlidingTabControllerDelegate?
   public var viewControllerArray = [UIViewController]()
    public var tabBackgroundColor = UIColor.white
    public var indicatorTintColor = UIColor(red: 67.0/255.0, green: 189.0/255.0, blue: 234.0/255.0, alpha: 1.0)
    public var indicatorHeight = 5.0
    
    public var selectedTabTitleColor = UIColor.white
    public var unSelectedTabTitleColor = UIColor.gray
    
    public var selecedTabTitleFont  = UIFont(name: "verdana", size: 14.0)
    public var unSelecedTabTitleFont  = UIFont(name: "verdana", size: 14.0)
    
    public var initialSelectedTabIndex:Int = 0
    public var titleLetterSpacing = 0.0
    
    fileprivate var previousPage:Int = 0
    fileprivate var buttonPreviousPage:Int = 0
    fileprivate var topNavHeight = 50.0
    fileprivate var scroll: UIScrollView!
    fileprivate var controllerContainerscroll: UIScrollView!
    fileprivate var indicatorView: UIView!
    fileprivate var xpos = 0.0
    fileprivate var width = 150.0
   
    
   public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: - textBeginNotification
    @objc func textBeginNotification(_ not: Notification) {
        controllerContainerscroll.isScrollEnabled = false
    }
    
    //MARK: - textEndNotification
    @objc func textEndNotification(_ not: Notification) {
        controllerContainerscroll.isScrollEnabled = true
    }
    
   public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scroll = UIScrollView()
        scroll.isUserInteractionEnabled = true
        scroll.showsHorizontalScrollIndicator = false
        self.view.addSubview(scroll)
        
        
        controllerContainerscroll = UIScrollView()
        controllerContainerscroll.isPagingEnabled = true
        controllerContainerscroll.showsHorizontalScrollIndicator = false
        self.view.addSubview(controllerContainerscroll)
        
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(textBeginNotification(_:)), name:UITextField.textDidBeginEditingNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textEndNotification(_:)), name:UITextField.textDidEndEditingNotification , object: nil)
    }
    
    fileprivate func setFrameOfSlidingTabVC(parentVC:UIViewController) {
        var frame = parentVC.view.frame
        var topSafeOffset:CGFloat = 0.0
        var bottomSafeOffset:CGFloat = 0.0
        if #available(iOS 11.0, *) {
            topSafeOffset = parentVC.view.safeAreaInsets.top
            bottomSafeOffset = parentVC.view.safeAreaInsets.bottom
        }
        frame.origin.y = topSafeOffset
        frame.size.height = UIScreen.main.bounds.size.height - (frame.origin.y + bottomSafeOffset )
        self.view.frame = frame
    }
    
   public func initWithViewController(controllers: [UIViewController], parentViewController: UIViewController, forHeight height:CGFloat) {
        topNavHeight = Double(height)
        setFrameOfSlidingTabVC(parentVC: parentViewController)
        scroll.backgroundColor = tabBackgroundColor

        viewControllerArray = controllers
        
        parentViewController.addChild(self)
        
       
        createTopBar()
        var frame  = self.view.frame
        frame.size.height = CGFloat(frame.size.height) - CGFloat(topNavHeight)
        controllerContainerscroll.delegate = self
        controllerContainerscroll.frame = CGRect(x: frame.origin.x, y: CGFloat(topNavHeight), width: UIScreen.main.bounds.size.width, height: frame.size.height)
        addController(controllers)
    }
    
    
    fileprivate func addController(_ controllerArray: [UIViewController])  {
        
        var xpos:CGFloat = 0.0
        
        for i in 0...controllerArray.count-1 {
            
            let vc = controllerArray[i] as AnyObject
            vc.view.frame = CGRect(x: xpos, y: 0.0, width: UIScreen.main.bounds.size.width, height: controllerContainerscroll.frame.size.height)
            controllerContainerscroll.addSubview(vc.view)
            self.addChild(vc as! UIViewController)
            xpos = xpos + UIScreen.main.bounds.size.width
        }
        controllerContainerscroll.contentSize = CGSize(width: xpos, height: controllerContainerscroll.frame.size.height)
        controllerContainerscroll.scrollRectToVisible(CGRect(x:  Double(UIScreen.main.bounds.size.width * CGFloat(initialSelectedTabIndex)), y: 0.0, width:  Double(UIScreen.main.bounds.size.width), height: Double(controllerContainerscroll.frame.size.height)), animated: false)
        setViewControllerAsChildVCForIndex(index: initialSelectedTabIndex)
    }
    
    fileprivate func createTopBar()  {
        scroll.frame = CGRect(x: 0.0, y: 0.0, width: Double(UIScreen.main.bounds.size.width), height: topNavHeight)
        
        
        if viewControllerArray.count < 3 {
            width  = Double(UIScreen.main.bounds.size.width/CGFloat(viewControllerArray.count))
        }
        for  i  in 0...viewControllerArray.count-1 {
            let tempVC = viewControllerArray[i]
            let titleButton = UIButton(frame: CGRect(x: xpos, y: 0.0, width: width, height: topNavHeight - indicatorHeight))
            titleButton.backgroundColor = UIColor.red
            titleButton.setTitle((tempVC as AnyObject).title, for: .normal)
            titleButton.setTitleColor(unSelectedTabTitleColor, for: .normal)
            titleButton.setTitleColor(selectedTabTitleColor, for: .selected)
            titleButton.titleLabel?.font = selecedTabTitleFont
            titleButton.titleLabel?.textAlignment = .center
            addLetterSpacing(toLabel: titleButton.titleLabel!, withLetterSpace: Float(titleLetterSpacing))
            titleButton.backgroundColor = self.view.backgroundColor
            titleButton.tag = i
            titleButton.isSelected = false
            previousPage = initialSelectedTabIndex
            buttonPreviousPage = initialSelectedTabIndex
            if i == initialSelectedTabIndex {
                titleButton.isSelected = true
            }
            titleButton.addTarget(self, action: #selector(clickedTabIndex(_:)), for: .touchUpInside)
            scroll.addSubview(titleButton)
            xpos = xpos + width
        }
        scroll.contentSize = CGSize(width: xpos, height: topNavHeight)
        indicatorView = UIView(frame: CGRect(x: 0.0, y: topNavHeight - indicatorHeight, width: width, height: indicatorHeight))
        indicatorView.backgroundColor = indicatorTintColor
        
        let bottomBorderView = UIView(frame: CGRect(x: 0.0, y: topNavHeight - indicatorHeight, width: xpos, height: indicatorHeight))
        bottomBorderView.backgroundColor = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        scroll.addSubview(bottomBorderView)
        scroll.addSubview(indicatorView)
        for bt in scroll.subviews {
            if bt is UIButton {
                let button = bt as! UIButton
                if button.tag == initialSelectedTabIndex {
                    clickedTabIndex(button)
                }
            }
        }
        
    }
    
   fileprivate  func setTittleSelected(for index:Int)  {
        
        for bt in scroll.subviews {
            if bt is UIButton {
                let button = bt as! UIButton
                button.isSelected = false
                if button.tag == index {
                    button.isSelected = true
                }
            }
        }
    }
    
    @objc fileprivate func clickedTabIndex(_ sender: UIButton) {
        
        var frame = sender.frame
        for bt in scroll.subviews {
            if bt is UIButton {
                let button = bt as! UIButton
                button.isSelected = false
                if button.tag == sender.tag {
                    frame = button.frame
                }
            }
        }
        setTittleSelected(for: sender.tag)
        setViewControllerAsChildVCForIndex(index: sender.tag)
        if indicatorView.frame.origin.x == frame.origin.x {
            return
        }
        indicatorView.frame.origin.x = frame.origin.x
        
        scroll.scrollRectToVisible(frame, animated: true)
        let org = CGFloat(sender.tag) * CGFloat(UIScreen.main.bounds.size.width)
        controllerContainerscroll.delegate = nil
        controllerContainerscroll.scrollRectToVisible(CGRect(x: CGFloat(org), y: 0.0, width: UIScreen.main.bounds.size.width, height: controllerContainerscroll.frame.size.height), animated: true)
        self.perform(#selector(setDelegatesToContainerScroll), with: nil, afterDelay: 0.3)
      
        if let dlg = self.delegate {
            dlg.currentSelectedIndex(sender.tag)
        }
        
        checkAndScrollMenuToVisibleOtherElements(index: sender.tag)
    }
    
    
    fileprivate func checkAndScrollMenuToVisibleOtherElements(index:Int) {
        if buttonPreviousPage < index {
            //move formwards
            buttonPreviousPage = index
            for bt in scroll.subviews {
                if bt is UIButton {
                    let button = bt as! UIButton
                    if button.tag == index + 1 {
                        scroll.scrollRectToVisible(button.frame, animated: true)
                    }
                }
            }
            
        } else {
            //move backward
            buttonPreviousPage = index
            for bt in scroll.subviews {
                if bt is UIButton {
                    let button = bt as! UIButton
                    if button.tag == index - 1 {
                        scroll.scrollRectToVisible(button.frame, animated: true)
                    }
                }
            }
            
        }
        
    }
    
    
    @objc fileprivate func setDelegatesToContainerScroll () {
        controllerContainerscroll.delegate = self
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset =  scrollView.contentOffset.x/(scrollView.contentSize.width/scroll.contentSize.width)
        if  offset > 0.0 {
            indicatorView.frame.origin.x = offset
        }
        else {
            indicatorView.frame.origin.x = 0.0
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset =  scrollView.contentOffset.x/(scrollView.contentSize.width/scroll.contentSize.width)
        scroll.scrollRectToVisible(CGRect(x: Double(offset), y: 0.0, width: width, height: topNavHeight - 5.0), animated: true)
        setTittleSelected(for: Int(CGFloat(offset)/CGFloat(width)))
        
        let pageWidth = scrollView.frame.size.width
        let fractionalPage = scrollView.contentOffset.x / pageWidth
        let page = lround(Double(fractionalPage))
        checkAndScrollMenuToVisibleOtherElements(index: page)
        if (previousPage != page) {
            // Page has changed, do your thing!
            // ...
            // Finally, update previous page
            previousPage = page;
            buttonPreviousPage = page
            if let dlg = self.delegate {
                dlg.currentSelectedIndex(previousPage)
            }
            setViewControllerAsChildVCForIndex(index: page)
        }
        
        
    }
    
    fileprivate func setViewControllerAsChildVCForIndex(index:Int) {
        
        let vc = self.viewControllerArray[index]
        if self.children.count > 0 {
            for _ in 0...self.children.count - 1 {
                vc.willMove(toParent: self)
                vc.removeFromParent()
                vc.didMove(toParent: self)
            }
        }
        
        vc.willMove(toParent: self)
        self.addChild(vc)
        vc.didMove(toParent: self)
    }
    
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   fileprivate func addLetterSpacing(toLabel label:UILabel, withLetterSpace spaceToAdd:Float )  {
        let attrString =  label.setTextSpacing(spacing: CGFloat(spaceToAdd), font: label.font)
        label.attributedText = attrString
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension UILabel {
    
    func setTextSpacing(spacing: CGFloat, font:UIFont) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: text!)
        if textAlignment == .center || textAlignment == .right {
            attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: attributedString.length))
            attributedString.addAttribute(NSAttributedString.Key.font,value: font, range: NSRange(location: 0, length: attributedString.length))
            
        } else {
            
            attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: attributedString.length-1))
            attributedString.addAttribute(NSAttributedString.Key.font,value: font, range: NSRange(location: 0, length: attributedString.length-1))
            
        }
        return attributedString
    }
}
