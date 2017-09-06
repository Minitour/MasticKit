//
//  MCNavigationBar.swift
//  design
//
//  Created by Tomer Goldfeder on 04/09/2017.
//  Copyright © 2017 Tomer Goldfeder. All rights reserved.
//

import UIKit

@IBDesignable
public class MCNavigationBar: UINavigationBar {
    
    open class var defaultHeight: CGFloat {
        return 58.0
    }
    
    open class var defaultRubberSize: CGFloat{
        return 200.0
    }
    
    fileprivate var statusBarView: UIView?
    
    fileprivate var backgroundImage: UIImageView?
    
    fileprivate var displayLink: CADisplayLink?
    
    fileprivate var scrollView: UIScrollView?{
        didSet{
            if didMove, oldValue == nil {
                setupLinker()
            }
            
            if scrollView == nil {
                disableLinker()
            }
        }
    }
    
    fileprivate var didMove: Bool = false
    
    fileprivate var titleLabel: UILabel?{
        for view in subviews{
            if "\(type(of: view))" == "UINavigationItemView" {
                for s in view.subviews{
                    if s is UILabel{
                        return s as? UILabel
                    }
                }
            }
        }
        return nil
    }
    
    open var heightValue: CGFloat  = MCNavigationBar.defaultHeight {
        didSet {
            frame.size.height = heightValue
            updateScrollInset()
            updateTitle()
        }
    }
    
    @IBInspectable
    public var statusBarColor: UIColor? {
        get {
            return statusBarView?.backgroundColor
        }
        set {
            if statusBarView == nil {
                statusBarView = UIView()
                statusBarView?.translatesAutoresizingMaskIntoConstraints = false
                statusBarView?.isUserInteractionEnabled = false
                addSubview(statusBarView!)
                statusBarView?.bottomAnchor.constraint(equalTo: topAnchor).isActive = true
                statusBarView?.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
                statusBarView?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
                statusBarView?.heightAnchor.constraint(equalToConstant: UIApplication.shared.statusBarFrame.height).isActive = true
                
            }
            statusBarView?.backgroundColor = newValue
        }
    }
    
    
    @IBInspectable
    open var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        
        set { layer.shadowRadius = newValue }
    }
    
    @IBInspectable
    open var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        
        set { layer.shadowOpacity = newValue }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        
        tintColor = .white
        barTintColor = #colorLiteral(red: 0.6431372549, green: 0.8039215686, blue: 0.8509803922, alpha: 1)
        barStyle = .black
        layer.shadowOpacity = 0.75
        layer.shadowRadius = 10.0
        layer.shadowColor = #colorLiteral(red: 0.1501606703, green: 0.3778939247, blue: 0.4593330026, alpha: 1).cgColor
        shadowImage = #colorLiteral(red: 0.7141833901, green: 0.842882514, blue: 0.8841859698, alpha: 1).as1ptImage()
        setBackgroundImage(#colorLiteral(red: 0.6431372549, green: 0.8039215686, blue: 0.8509803922, alpha: 1).as1ptImage(), for: .default)
        statusBarColor = #colorLiteral(red: 0.1501606703, green: 0.3778939247, blue: 0.4593330026, alpha: 1)
        
        let attributes = [NSFontAttributeName : UIFont(name: "Verdana-Bold", size: 18)!, NSForegroundColorAttributeName : #colorLiteral(red: 0.1162508164, green: 0.2967372687, blue: 0.3616767526, alpha: 1)] as [String : Any]
        titleTextAttributes = attributes
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        subviews.filter { (subview) -> Bool in
            return subview is UIButton
            }.forEach { (subview) in
                subview.center.y = frame.height / 2
        }
        
        if backgroundImage == nil {
            loop:
            for view in subviews{
                if "\(type(of: view))" == "_UIBarBackground"{
                    for sub in view.subviews{
                        if sub is UIImageView{
                            if sub.frame.size.height > 1.0{
                                backgroundImage = sub as? UIImageView
                                break loop
                            }
                        }
                    }
                }
            }
        }
        
        backgroundImage?.alpha = 1.0
        
        centerViews()
        
        updateTitle()
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let superSize = super.sizeThatFits(size)
        return CGSize(width: superSize.width, height: heightValue)
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        didMove = true
        
        if scrollView != nil { setupLinker() }
        else { disableLinker() }
    }
    
    fileprivate func setupLinker(){
        if displayLink != nil {
            displayLink?.invalidate()
        }
        
        displayLink = CADisplayLink(target: self, selector: #selector(animationTime(linker:)))
        displayLink?.preferredFramesPerSecond = 60
        displayLink?.add(to: RunLoop.main, forMode: .commonModes)
        updateInsets(statusVisable: !UIApplication.shared.isStatusBarHidden)
    }
    
    fileprivate func centerViews(){
        for subview in subviews {
            if  "\(type(of: subview))" == "UINavigationButton"
                || "\(type(of: subview))" == "UINavigationItemView"
                || "\(type(of: subview))" == "_UINavigationBarBackIndicatorView"
                || "\(type(of: subview))" == "UINavigationItemButtonView"{
                subview.center = CGPoint(x: subview.center.x, y: frame.height / 2)
            }
            
        }
    }
    
    fileprivate func disableLinker(){
        if displayLink != nil{
            displayLink?.invalidate()
        }
    }
    
    fileprivate func updateScrollInset() {
        if let scrollView = scrollView{
            let si = scrollView.scrollIndicatorInsets
            let statusBarVisable = !UIApplication.shared.isStatusBarHidden
            let height = frame.height + (statusBarVisable ? 20.0 : 0.0)
                
            scrollView.scrollIndicatorInsets = UIEdgeInsets(top: height, left: si.left, bottom: si.bottom, right: si.right)
        }
    }
    
    fileprivate func updateTitle(){
        if let titleHeight = titleLabel?.frame.height {
           setTitleVerticalPositionAdjustment(-heightValue / 2.0 + titleHeight, for: .default)
        }
    }
    
    fileprivate func centerSubViewsOf(_ view: UIView){
        for sub in view.subviews {
            sub.center = CGPoint(x: sub.center.x, y: view.frame.height / 2)
        }
    }
    
    fileprivate func centerLabel(y: CGFloat){
        titleLabel?.center.y = y
    }
    
    fileprivate func pushedController(){
        scrollView = nil
        centerViews()
        UIView.animate(withDuration: 0.3) {[weak self] in
            self?.heightValue = MCNavigationBar.defaultHeight
        }
        
        
    }
    
    func animationTime(linker: CADisplayLink){
        
        if let scrollView = scrollView {
            let offset =
                scrollView.contentOffset.y +
                scrollView.contentInset.top +
                scrollView.contentInset.bottom
            
            if offset < 0 {
                let precent = offset / scrollView.frame.height
                let newHeight = MCNavigationBar.defaultHeight + (-precent) * MCNavigationBar.defaultRubberSize
                heightValue = newHeight
            }
        }
    }
    
}

extension UINavigationBar{
    
    func didPush(){
        if self is MCNavigationBar{
            (self as! MCNavigationBar).pushedController()
        }
    }
    
    func hook(scrollView: UIScrollView){
        if self is MCNavigationBar{
            (self as! MCNavigationBar).scrollView = scrollView
        }
    }
    
    func updateInsets(statusVisable: Bool){
        if self is MCNavigationBar,
            let scrollView = (self as! MCNavigationBar).scrollView {
            
            let ci = scrollView.contentInset
            let height: CGFloat = frame.height
            let statusBar: CGFloat = statusVisable ? 20.0 : 0.0
            
            scrollView.contentInset =
                UIEdgeInsets(top: height + statusBar,left: ci.left,
                             bottom: ci.bottom,right: ci.right)
        }
    }
}

fileprivate extension UIColor {
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        let ctx = UIGraphicsGetCurrentContext()
        self.setFill()
        ctx!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

