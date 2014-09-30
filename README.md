# SwipeAwayTableViewController

A simple subclass of `UITableViewController`. Have your modal TableViewControllers inherit from it, and you'll be able to dismiss them by swiping downwards at the top of the table.

<img src="https://raw.githubusercontent.com/nate-parrott/SwipeAwayTableViewController/master/demo.gif"  style="height:300px" />

## Usage

Create a subclass of `SwipeAwayTableViewController`, then present it modally. **Make sure to set the view controller's `modalPresentationStyle` to Custom and its `transitioningDelegate` to itself.

    let presentingVC = ExampleModalTableViewController()
    
    // for the effect to work, .modalPresentationStyle must be set to .Custom, and...
    presentingVC.modalPresentationStyle = UIModalPresentationStyle.Custom
    // ... the view's transitioningDelegate must be itself
    presentingVC.transitioningDelegate = presentingVC
    
    presentViewController(presentingVC, animated: true, completion: nil)

