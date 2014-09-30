//
//  PresentingViewController.swift
//  Example
//
//  Created by Nate Parrott on 9/30/14.
//  Copyright (c) 2014 Nate Parrott. All rights reserved.
//

import UIKit

class PresentingViewController: UIViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let presentingVC = segue.destinationViewController as ExampleModalTableViewController
        
        // for the effect to work, .modalPresentationStyle must be set to .Custom, and...
        presentingVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        // ... the view's transitioningDelegate must be itself
        presentingVC.transitioningDelegate = presentingVC
    }
    
}
