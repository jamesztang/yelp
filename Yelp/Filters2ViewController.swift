//
//  Filters2ViewController.swift
//  Yelp
//
//  Created by James Tang on 9/21/15.
//  Copyright © 2015 Codepath. All rights reserved.
//     

import UIKit

protocol OfferingDealSwitchDelegate {
    func offeringDealSwitch(offeringDealSwitch: UISwitch, didChangeValue: Bool)
}

protocol CategorySwitchDelegate {
    func categorySwitch(categorySwitch: UISwitch, didChangeValue: Bool)
}

protocol DistancePickerDelegate {
    func distancePicker(distancePicker: UIPickerView, didSelectRow row: Int, inComponent component: Int)
}


class Filters2ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    @IBOutlet weak var offeringDealSwitch: UISwitch!
    @IBOutlet weak var distancePickerView: UIPickerView!
    
    var offeringDealSwitchDelegate: OfferingDealSwitchDelegate?
    var categorySwitchDelegate:     CategorySwitchDelegate?
    var distancePickerDelegate:     DistancePickerDelegate?
    
    var distancePickerDataSource = ["1 mile", "2 miles", "3 miles", "4 miles", "5 miles", "6 miles", "7 miles", "8 miles", "9 miles", "10 miles"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.distancePickerView.dataSource = self
        self.distancePickerView.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onOfferingDealValueChanged(sender: AnyObject) {
//        NSLog("onOfferingDealValueChanged \(offeringDealSwitch.on)")
        let theSwitch = sender as! UISwitch
        offeringDealSwitchDelegate?.offeringDealSwitch(theSwitch, didChangeValue: theSwitch.on)
    }
    
    @IBAction func onCategoryValueChanged(sender: AnyObject) {
//        NSLog("onCategoryValueChanged \(theSwitch.on)")
        let theSwitch = sender as! UISwitch
        categorySwitchDelegate?.categorySwitch(theSwitch, didChangeValue: theSwitch.on)
    }
    
    @IBAction func onCancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /* UIPickerViewDataSource */
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        NSLog("numberOfComponentsInPickerView")
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        NSLog("numberOfRowsInComponent")
        return distancePickerDataSource.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return distancePickerDataSource[row]
    }
    
    /* UIPickerViewDelegate */
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        NSLog("didSelectRow \(row)")
        distancePickerDelegate?.distancePicker(pickerView, didSelectRow: row, inComponent: component)
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
