//
//  ViewController.swift
//  Remind Me
//
//  Created by Jeremy Harman on 7/5/15.
//  Copyright (c) 2015 Jeremy Harman. All rights reserved.
//

import UIKit

class EditTableViewController: UIViewController {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var temDescription: UITextField!
    @IBOutlet weak var time: UIDatePicker!
    
    var newEntry: ListEntryInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* set up the fields of the new ListEntryInput object */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if sender as? NSObject != self.doneButton{
            return
        }
        
        if count(self.temDescription.text) > 0 {
            
            var outputFormat = NSDateFormatter()
            outputFormat.locale = NSLocale(localeIdentifier:"en_US")
            outputFormat.dateFormat = "HH:mm"
            var strTime = (outputFormat.stringFromDate(self.time.date)) as String
            
            var hours = strTime.substringWithRange(Range<String.Index>(start: strTime.startIndex, end: advance(strTime.endIndex, -3))).toInt()
            var minutes = strTime.substringWithRange(Range<String.Index>(start: advance(strTime.startIndex, 3), end: strTime.endIndex)).toInt()
            var isAM = true
            
            if hours > 12 {
                isAM = false
                hours = hours! - 12
            }
            if hours == 0 {
                hours = 12
            }
            
            self.newEntry = ListEntryInput()
            self.newEntry!.setValues(hours!, minutes:minutes!, message: temDescription.text, isAM: isAM)
            
        }
    }
}

