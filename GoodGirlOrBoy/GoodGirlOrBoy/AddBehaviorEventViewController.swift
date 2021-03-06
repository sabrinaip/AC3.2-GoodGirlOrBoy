//
//  AddBehaviorEventViewController.swift
//  GoodGirlOrBoy
//
//  Created by Sabrina Ip on 1/2/17.
//  Copyright © 2017 Sabrina. All rights reserved.
//

import UIKit
import CoreData

class AddBehaviorEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var behaviorPickerView: UIPickerView!
    @IBOutlet weak var selectBehaviorLabel: UILabel!
    
    var proSocial = true
    var pickerData = [[String]]()
    var childrenNames = ["Harry", "Hermione", "Ron"]
    var goodBehaviors = ["shaing", "clearing the table", "finishing dinner", "saying thank you", "apologizing", "doing homework"]
    var badBehaviors = ["throwing", "running in the house", "hitting", "biting"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if proSocial {
            selectBehaviorLabel.text = "Please select the pro-social behavior"
            pickerData = [childrenNames, goodBehaviors]
        } else {
            selectBehaviorLabel.text = "Please select the anti-social behavior"
            pickerData = [childrenNames, badBehaviors]
        }
    }
    
    // MARK: - PickerView
    // SOURCE: modified code from http://codewithchris.com/uipickerview-example/
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    // MARK: - Save into CoreData
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
        let behaviorEvent = BehaviorEvent(context: context)
        behaviorEvent.timeStamp = NSDate()
        behaviorEvent.proSocial = proSocial
        behaviorEvent.childName = childrenNames[behaviorPickerView.selectedRow(inComponent: 0)]
        if proSocial {
            behaviorEvent.observedBehavior = goodBehaviors[behaviorPickerView.selectedRow(inComponent: 1)]
        } else {
            behaviorEvent.observedBehavior = badBehaviors[behaviorPickerView.selectedRow(inComponent: 1)]
        }
        if context.hasChanges {
            try! context.save()
        }
        _ = self.navigationController?.popViewController(animated: true)
    }
}
