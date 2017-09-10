//
//  MCTableViewController.swift
//  MasticExample
//
//  Created by Antonio Zaitoun on 10/09/2017.
//  Copyright © 2017 Antonio Zaitoun. All rights reserved.
//

import UIKit


public class MCTableViewController: UITableViewController {
    
    public override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath){
            tableView.wrapper?.bringSubview(toFront: cell)
            
            if indexPath.row == 0 {
                cell.clipsToBounds = true
            }
        }
    }
    
}
