//
//  TableViewController.swift
//  MasticExample
//
//  Created by Antonio Zaitoun on 06/09/2017.
//  Copyright © 2017 Antonio Zaitoun. All rights reserved.
//

import UIKit

public class TableViewController: MCTableViewController{
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hook(scrollView: tableView, inside: self)
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
