//
//  MCTableViewCell.swift
//  MasticExample
//
//  Created by Antonio Zaitoun on 07/09/2017.
//  Copyright © 2017 Antonio Zaitoun. All rights reserved.
//

import UIKit

@IBDesignable
public class MCTableViewCell: UITableViewCell{

    fileprivate var borderView: UIView?
   
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if isSelected || isHighlighted {
            let object1 = UIBezierPath()
            object1.move(to: CGPoint(x: 0.0, y: 0.0))
            object1.addLine(to: CGPoint(x: rect.width, y: 0.0))
            object1.move(to: CGPoint(x: 0.0, y: rect.height))
            object1.addLine(to: CGPoint(x: rect.width, y: rect.height))
            object1.close()
            #colorLiteral(red: 0.8654696345, green: 0.9059456587, blue: 0.9143808484, alpha: 1).set()
            object1.lineWidth = 4.0
            object1.stroke()
        }
        
    }
    
    @IBInspectable
    var selectedColor: UIColor = UIColor.lightGray {
        didSet {
            backgroundColor = selectedColor
        }
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup(){
        selectedColor = #colorLiteral(red: 0.9445480704, green: 0.9607601762, blue: 0.969013989, alpha: 1)
        borderView = UIView()
        insertSubview(borderView!, at: 0)
        borderView?.translatesAutoresizingMaskIntoConstraints = false
        borderView?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        borderView?.leftAnchor.constraint(equalTo: leftAnchor, constant: -4.0).isActive = true
        borderView?.rightAnchor.constraint(equalTo: rightAnchor, constant: 4.0).isActive = true
        borderView?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        modify(enabled: selected, animated: animated)
    }
    
    override public func setHighlighted(_ highlighted: Bool, animated: Bool) {
        modify(enabled: highlighted, animated: animated)
    }

    
    fileprivate func modify(enabled: Bool, animated: Bool){
        if(enabled) {
            updateUI(color: selectedColor, animated: animated)
            borderView?.layer.borderColor = #colorLiteral(red: 0.8654696345, green: 0.9059456587, blue: 0.9143808484, alpha: 1).cgColor
            borderView?.layer.borderWidth = 2.0
        } else {
            updateUI(color: .white, animated: animated)
            borderView?.layer.borderColor = #colorLiteral(red: 0.8654696345, green: 0.9059456587, blue: 0.9143808484, alpha: 1).cgColor
            borderView?.layer.borderWidth = 0.0
        }
    }
    
    fileprivate func updateUI(color: UIColor, animated: Bool){
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.backgroundColor = color
            }
        }else{
            backgroundColor = color
            self.backgroundColor = color
        }
    }
    
}

fileprivate class MCCellBackgroundView: UIView{
    
    
    
}
