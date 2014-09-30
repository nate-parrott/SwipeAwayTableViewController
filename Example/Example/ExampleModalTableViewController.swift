//
//  ExampleModalTableViewController.swift
//  Example
//
//  Created by Nate Parrott on 9/30/14.
//  Copyright (c) 2014 Nate Parrott. All rights reserved.
//

import UIKit

class ExampleModalTableViewController: SwipeAwayTableViewController {

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    
    override func topMargin() -> CGFloat {
        return 90
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.SpellOutStyle
        let text = formatter.stringFromNumber(indexPath.row)
        let tableCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        tableCell.textLabel!.text = text
        return tableCell
    }

}
