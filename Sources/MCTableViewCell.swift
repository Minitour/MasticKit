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
    
    @IBInspectable
    var selectedColor: UIColor = UIColor.lightGray {
        didSet {
            contentView.backgroundColor = selectedColor
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
        focusStyle = .custom
        
    }
    
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        if(selected) {
            if animated {
                UIView.animate(withDuration: 0.3) {
                    self.contentView.backgroundColor = self.selectedColor
                }
            }else{
                contentView.backgroundColor = selectedColor
            }
            
        } else {
            if animated {
                UIView.animate(withDuration: 0.3) {
                    self.contentView.backgroundColor = UIColor.white
                }
            }else{
                contentView.backgroundColor = UIColor.white
            }
            
        }
    }
    
    override public func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if(highlighted) {
            if animated {
                UIView.animate(withDuration: 0.3) {
                    self.contentView.backgroundColor = self.selectedColor
                }
            }else{
                contentView.backgroundColor = selectedColor
            }
            
        } else {
            if animated {
                UIView.animate(withDuration: 0.3) {
                    self.contentView.backgroundColor = UIColor.white
                }
            }else{
                contentView.backgroundColor = UIColor.white
            }
            
        }
    }
    
}
