//
//  FiltersViewController.swift
//  Yelp
//
//  Created by James Tang on 9/20/15.
//  Copyright © 2015 Codepath. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var categories: [[String:String]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categories = yelpCategories()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onSearchButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Switch Table View Cell", forIndexPath: indexPath) as! SwitchTableViewCell
        cell.switchLabel.text = categories[indexPath.row]["name"]
        return cell
    }
    
    func yelpCategories() -> [[String:String]] {
        return [
            ["name" : "Afghan", "code" : "afghani"],
            ["name" : "African", "code" : "african"],
            ["name" : "American, New", "code" : "newamerican"],
            ["name" : "American, Traditional", "code" : "tradamerican"],
            ["name" : "Arabian", "code" : "arabian"],
            ["name" : "Argentine", "code" : "argentine"],
        ]
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
