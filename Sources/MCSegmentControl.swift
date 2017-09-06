//
//  CustomizeSegmentControl.swift
//  design
//
//  Created by Tomer Goldfeder on 06/09/2017.
//  Copyright © 2017 Tomer Goldfeder. All rights reserved.
//

import UIKit

@IBDesignable
public class MCSegmentControl: UIControl {
    
    @IBInspectable
    open var interfacePresentation: String = "Label 1,Label 2,Label 3"
    
    fileprivate var labels = [UILabel]()
    
    fileprivate var temp: Int = 0
    
    fileprivate lazy var thumbView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        return view
    }()
    
    open var items: [String] = ["Label 1", "Label 2", "Label 3"] {
        didSet {
            setupLabels()
            selectedItem = 0
        }
    }
    
    open var selectedItem : Int = 0 {
        didSet {
            displaySelectedItem()
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    
    /**
        adjusting the layer: corners, border..
     */
    
    fileprivate func setupView() {
        layer.cornerRadius = frame.height / 2
        backgroundColor = #colorLiteral(red: 0.8528466821, green: 0.8965204358, blue: 0.9113846421, alpha: 1)
        
        setupLabels()
        
        insertSubview(thumbView, at: 0)
    }
    
    
    /**
        setting the label that are not selected
     */
    
    fileprivate func setupLabels() {
        for label in labels {
            label.removeFromSuperview()
        }
        
        labels.removeAll()
        
        var index = 0
        for item in items {
            let label = UILabel(frame : CGRect.zero)
            label.text = item
            label.textAlignment = .center
            label.textColor = #colorLiteral(red: 0.3372224569, green: 0.3372756839, blue: 0.337210834, alpha: 1)
            if (index == selectedItem) {
                label.font = UIFont.boldSystemFont(ofSize: 17.0)
            }
            else {
                label.font = UIFont.boldSystemFont(ofSize: 15.0)
            }
            self.addSubview(label)
            labels.append(label)
            index += 1
        }
    }
    
    
    /**
        adjusting the labels in the view
     */
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        //layout thumbView
        layoutThumbView()
        
        //layout labels
        layoutLabels()
    }
    
    fileprivate func layoutThumbView(){
        var selectedFrame: CGRect = .zero
        let newWidth = frame.width / CGFloat(items.count)
        selectedFrame.size.width = newWidth
        selectedFrame.size.height = frame.height
        print(frame.height)
        selectedFrame.origin.x = CGFloat(selectedItem) * newWidth
        selectedFrame.origin.y = 0.0
        thumbView.frame = selectedFrame
        thumbView.backgroundColor = #colorLiteral(red: 0.9999127984, green: 1, blue: 0.9998814464, alpha: 1)
        thumbView.layer.cornerRadius = thumbView.frame.height/2
    }
    
    fileprivate func layoutLabels(){
        let labelHeight = frame.height
        let labelWidth = frame.width/CGFloat(labels.count)
        
        for index in 0..<labels.count {
            let label = labels[index]
            let xPosition = CGFloat(index) * labelWidth
            
            label.frame = CGRect(x: xPosition, y: 0, width: labelWidth, height: labelHeight)
        }
    }
    
    
    /**
        selecting the right label according to the position and check in which 
        label the click happened
     */
    override public func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        if let realLocation = touch?.location(in: self){
            let fakeLocation = CGPoint(x: realLocation.x,y: 0.0)
            
            for i in 0..<labels.count {
                if labels[i].frame.contains(fakeLocation) {
                    selectedItem = i
                }
            }
        }
        if temp != selectedItem{
            sendActions(for: .valueChanged)
        }
    }
    
    override public func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        temp = selectedItem
        return true
    }
    
    override public func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let realLocation = touch.location(in: self)
        let fakeLocation = CGPoint(x: realLocation.x,y: 0.0)
        
        for i in 0..<labels.count {
            if labels[i].frame.contains(fakeLocation) {
                selectedItem = i
            }
        }
        
        return true
    }
    
    
    /**
        displaying the selected label, assigning shadow, animation and removing the shadow 
        from the other labels
     */
    
    func displaySelectedItem() {
        let label = labels[selectedItem]
        
        
        //changing the font from bold to regular to the unselected labels
        
        for label1 in labels {
            if label1 != label {
                label1.font = UIFont.boldSystemFont(ofSize: 15.0)
            }
        }
        
        //bolding the texts
        
        label.font = UIFont.boldSystemFont(ofSize: 17.0)
 
        
        //adding the animation
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5, options: [.curveEaseOut] ,animations: {
            
                self.thumbView.frame = label.frame
            
            }, completion: nil)
        
    }
    
    public override func prepareForInterfaceBuilder() {
        items = interfacePresentation.characters.split{$0 == ","}.map(String.init)
        layer.cornerRadius = frame.height / 2
        backgroundColor = #colorLiteral(red: 0.8528466821, green: 0.8965204358, blue: 0.9113846421, alpha: 1)
        super.prepareForInterfaceBuilder()
        thumbView.removeFromSuperview()
        let view = UIView()
        var selectedFrame: CGRect = .zero
        let newWidth = frame.width / CGFloat(items.count)
        selectedFrame.size.width = newWidth
        selectedFrame.size.height = frame.height
        print(frame.height)
        selectedFrame.origin.x = 0.0
        selectedFrame.origin.y = 0.0
        view.frame = selectedFrame
        view.backgroundColor = #colorLiteral(red: 0.9999127984, green: 1, blue: 0.9998814464, alpha: 1)
        view.layer.cornerRadius = view.frame.height/2
        
        view.isUserInteractionEnabled = false
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        insertSubview(view, at: 0)
    }
    
}


