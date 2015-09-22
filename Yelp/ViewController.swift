//
//  TableViewController.swift
//  Yelp
//
//  Created by James Tang on 9/16/15.
//  Copyright © 2015 Codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, OfferingDealSwitchDelegate, CategorySwitchDelegate, DistancePickerDelegate {

    var businesses: NSArray?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    func offeringDealSwitch(offeringDealSwitch: UISwitch, didChangeValue: Bool) {
        NSLog("offeringDealSwitch \(offeringDealSwitch.tag) \(didChangeValue)")
    }
    
    func categorySwitch(categorySwitch: UISwitch, didChangeValue: Bool) {
        NSLog("categorySwitch \(categorySwitch.tag) \(didChangeValue)")
    }
    
    func distancePicker(distancePicker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        NSLog("distancePicker \(row)")
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        NSLog(searchBar.text!)
        searchBar.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 90
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let yelpURLString = "http://localhost/~ztang1/yelp.json"
        let request = NSMutableURLRequest(URL: NSURL(string: yelpURLString)!)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            if let dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                dispatch_async(dispatch_get_main_queue()) {
                    self.businesses = dictionary["businesses"] as? NSArray
                    self.tableView.reloadData()
                }
                NSLog("Dictionary: \(dictionary)")
            }
            else {
                
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses?.count ?? 0
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let business = businesses![indexPath.row] as! NSDictionary
        let cell = tableView.dequeueReusableCellWithIdentifier("Table View Cell", forIndexPath: indexPath) as! BusinessTableViewCell
        
        cell.nameLabel.text = business["name"] as? String
        cell.distanceLabel.text = business[""] as? String
        cell.reviewsLabel.text = (business["review_count"]?.description)! + " Reviews"
        
        let addresses = business.valueForKeyPath("location.display_address") as! NSArray
        cell.addressLabel.text = (addresses[0] as! String) + ", " + (addresses[1] as! String) + ", " + (addresses[2] as! String)
        
        let categories = business["categories"] as? [[String]]
        var categoriesText: String = ""
        if categories != nil {
            var categoryNames = [String]()
            for category in categories! {
                let categoryName = category[0]
                categoryNames.append(categoryName)
            }
            categoriesText = categoryNames.joinWithSeparator(", ")
        }
        else {
            categoriesText = ""
        }
        cell.categoriesLabel.text = categoriesText
        
        cell.thumbImageView.contentMode = UIViewContentMode.ScaleAspectFit
        cell.ratingsImageView.contentMode = UIViewContentMode.ScaleAspectFit
       
        let thumbImageURL = business.valueForKeyPath("image_url") as! String
        if let checkedThumbImageURL = NSURL(string: thumbImageURL) {
            downloadImage(checkedThumbImageURL, imageView: cell.thumbImageView)
        }
        let ratingsImageURL = business.valueForKeyPath("rating_img_url_small") as! String
        if let checkedRatingsImageURL = NSURL(string: ratingsImageURL) {
            downloadImage(checkedRatingsImageURL, imageView: cell.ratingsImageView)
        }
        return cell
    }

    func downloadImage(url:NSURL, imageView: UIImageView) {
        getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = UIImage(data: data!)
            }
        }
    }
    
    func getDataFromUrl(urL: NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: data)
            }.resume()
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        NSLog("prepareForSegue")
        let navigationController = segue.destinationViewController as! UINavigationController
        let filters2ViewController = navigationController.visibleViewController as! Filters2ViewController
        filters2ViewController.offeringDealSwitchDelegate = self
        filters2ViewController.categorySwitchDelegate = self
        filters2ViewController.distancePickerDelegate = self
    }
    

}
