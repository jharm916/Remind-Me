//
//  TableViewController.swift
//  Remind Me
//
//  Created by Jeremy Harman on 7/5/15.
//  Copyright (c) 2015 Jeremy Harman. All rights reserved.
//

import Foundation
import UIKit

class InitTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var initTableView: UITableView!
    
    var i = 0
    var hours = 8
    var isAM = true
    var entryList = [ListEntryInput]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView.dataSource = self
        initTableView.delegate = self
        initTableView.backgroundColor = UIColor.blackColor()
        navigationItem.leftBarButtonItem = editButtonItem()
        loadInitialData()
    }
    
    /* initial contents are a list of empty times */
    func loadInitialData() {
        self.i = 0
        self.hours = 6
        self.isAM = true
        
        while self.i < 24 {
            var newItem: ListEntryInput = ListEntryInput()
            newItem.setValues(self.hours, minutes:0, message: "", isAM: self.isAM)
                
            self.entryList.append(newItem);
            self.i++
            self.hours++;
            if (self.hours == 13) {
                self.hours = 1
                if (self.isAM) {
                    self.isAM = false
                }
                else {
                    self.isAM = true
                }
            }
        }
        self.tableView.reloadData()
    }
    
    /* get the number of items in the list */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryList.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /* Determines what the cells of the table look like */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("EntryListCell", forIndexPath: indexPath) as! ListEntryInput
        let item = entryList[indexPath.row]
        
        cell.labelField.text = toString(item.hour) + ":" + item.GetPaddedMinutes() + " " + item.GetTimePeriod()
        cell.configure(text: item.message as String, placeholder: "")
        
        cell.textField.setTranslatesAutoresizingMaskIntoConstraints(false)
        cell.contentView.addConstraint(NSLayoutConstraint(item: cell.textField, attribute: .Left, relatedBy: .Equal, toItem: cell.contentView, attribute: .Right, multiplier: 1, constant: 2))
        
        cell.contentView.addConstraint(NSLayoutConstraint(item: cell.textField, attribute: .Right, relatedBy: .Equal, toItem: cell.contentView, attribute: .Right, multiplier: 1, constant: -7))
        
        return cell
    }
    
    /* determines the index to insert the new element at */
    func getInsertIndex(entry: ListEntryInput) -> Int {
        
        var index: Int = 0
        
        if (entry.hour >= 6 && entry.hour <= 12 && entry.isAM == true) {
            while (index < entryList.count && entry.hour > entryList[index].hour) {
                index++
            }
            while (index < entryList.count && entry.hour == entryList[index].hour && entry.minutes > entryList[index].minutes) {
                index++
            }
        }
        else if (entry.hour >= 1 && entry.hour <= 12 && entry.isAM == false) {
            while (index < entryList.count && entryList[index].isAM == true) {
                index++
            }
            while (index < entryList.count && entry.hour > entryList[index].hour) {
                index++
            }
            while (index < entryList.count && entry.hour == entryList[index].hour && entry.minutes > entryList[index].minutes) {
                index++
            }
        }
        else if (entry.hour >= 1 && entry.hour < 5 && entry.isAM == true) {
            while (index < entryList.count && entryList[index].isAM == true) {
                index++
            }
            while (index < entryList.count && entryList[index].isAM == false) {
                index++
            }
            while (index < entryList.count && entry.hour > entryList[index].hour) {
                index++
            }
            while (index < entryList.count && entry.hour == entryList[index].hour && entry.minutes > entryList[index].minutes) {
                index++
            }
        }
        else if (entry.hour == 5 && entry.isAM == true) {
            while (index < entryList.count && entryList[index].hour == 5 && entryList[index].isAM == true && entry.minutes > entryList[index].minutes) {
                index++
            }
        }
        
        return index
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            entryList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Top)
            if entryList.count == 0 {
                navigationItem.leftBarButtonItem = nil
            }
        }
    }
    
    /* entry point on EditTableViewController button clicks. adds the new entry to the table */
    @IBAction func backToInitial(segue:UIStoryboardSegue) {
        var source: EditTableViewController = segue.sourceViewController as! EditTableViewController
        
        if var item: ListEntryInput = source.newEntry {
            var index = getInsertIndex(source.newEntry!)
            self.entryList.insert(item, atIndex: index)
            self.tableView.reloadData()
        }
    }
    
}