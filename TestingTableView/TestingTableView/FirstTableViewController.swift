//
//  FirstTableViewController.swift
//  TestingTableView
//
//  Created by Myilone Anandarajah on 5/09/2015.
//  Copyright © 2015 Myilone Anandarajah. All rights reserved.
//

import UIKit

class FirstTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private var stringsToDisplay:[String] = ["Apple", "Orange", "Pare"]
    private var keyBoardHeight:CGFloat = 0
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postButtonPress(sender: AnyObject)
    {
        stringsToDisplay.append(commentTextField.text!)
        self.tableView.reloadData()
        commentTextField.text = ""
        commentTextField.resignFirstResponder()
    }

    // MARK: - Handling of moving the view with the keyboard
    func keyboardWillShow(notification: NSNotification)
    {
        //var keyboardSize = notification.userInfo(valueForKey(UIKeyboardFrameBeginUserInfoKey))
        if let userInfo = notification.userInfo {
            if let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
                self.keyBoardHeight = keyboardSize.height
                
                if (self.view.frame.origin.y >= 0)
                {
                    self.setViewMovedUp(true)
                }
                else if (self.view.frame.origin.y < 0)
                {
                    self.setViewMovedUp(false)
                }

            } else {
                // no UIKeyboardFrameBeginUserInfoKey entry in userInfo
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification)
    {
        setViewMovedUp(false)
    }
    
    func setViewMovedUp (movedUp:Bool)
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        
        var rect:CGRect = self.view.frame;
        
        if (movedUp)
        {
            rect.size.height -= self.keyBoardHeight;
        }
        else
        {
            // revert back to the normal state.
            rect.size.height += self.keyBoardHeight;
        }
        
        self.view.frame = rect;
        
        UIView.commitAnimations()
    }
    
    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stringsToDisplay.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = stringsToDisplay[indexPath.row];
        
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
