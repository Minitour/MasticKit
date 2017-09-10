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
        borderView?.topAnchor.constraint(equalTo: topAnchor, constant: -2.0).isActive = true
        borderView?.leftAnchor.constraint(equalTo: leftAnchor, constant: -4.0).isActive = true
        borderView?.rightAnchor.constraint(equalTo: rightAnchor, constant: 4.0).isActive = true
        borderView?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        borderView?.layer.borderColor = #colorLiteral(red: 0.8654696345, green: 0.9059456587, blue: 0.9143808484, alpha: 1).cgColor
        borderView?.backgroundColor = selectedColor
        borderView?.layer.borderWidth = 2.0
        borderView?.alpha = 0.0
        clipsToBounds = false
        backgroundColor = .white
    }
    
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        modify(enabled: selected, animated: animated)
    }
    
    override public func setHighlighted(_ highlighted: Bool, animated: Bool) {
        modify(enabled: highlighted, animated: animated)
    }

    
    fileprivate func modify(enabled: Bool, animated: Bool){
        if(enabled) {
            if animated {
                UIView.animate(withDuration: 0.3) {
                    self.borderView?.alpha = 1.0
                }
            }else{
                borderView?.alpha = 1.0
            }
            
        } else {
            if animated {
                UIView.animate(withDuration: 0.3) {
                    self.borderView?.alpha = 0.0
                }
            }else{
                borderView?.alpha = 0.0
            }
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.backgroundColor = .clear
    }
    
}

fileprivate class MCCellBackgroundView: UIView{
    
    
    
}
