//
//  MCTableView.swift
//  MasticExample
//
//  Created by Antonio Zaitoun on 07/09/2017.
//  Copyright © 2017 Antonio Zaitoun. All rights reserved.
//

import UIKit

@IBDesignable
public class MCTableView: UITableView {
    
    
    
    public override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    fileprivate func setup(){
        separatorColor = #colorLiteral(red: 0.7634159923, green: 0.8079883456, blue: 0.812315166, alpha: 1)
        backgroundColor = #colorLiteral(red: 0.5940496325, green: 0.7761380076, blue: 0.8309935927, alpha: 1)
    }
    
    
}
