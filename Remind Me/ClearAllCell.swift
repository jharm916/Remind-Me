//
//  ClearAllCell.swift
//  Remind Me
//
//  Created by Jeremy Harman on 8/25/15.
//  Copyright (c) 2015 Jeremy Harman. All rights reserved.
//

import Foundation
import UIKit

public class ClearAllCell: UITableViewCell {
    
}

/*
public class ListEntryInput: UITableViewCell {
    
    @IBOutlet weak var labelField: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    public var hour = 0
    public var minutes = 0
    public var message: NSString = ""
    public var isAM = false
    
    public func configure(#text: String?, placeholder: String) {
        textField.text = text
        textField.placeholder = placeholder
        textField.accessibilityValue = text
        textField.accessibilityLabel = placeholder
        textField.autoresizingMask = .FlexibleLeftMargin
    }
    
    public func setValues (var hour: Int, var minutes: Int, var message: NSString, var isAM: Bool) {
        self.hour = hour
        self.minutes = minutes
        self.message = message
        self.isAM = isAM
    }
    
    public func GetPaddedMinutes() -> String {
        if (self.minutes < 10) {
            return "0" + toString(self.minutes)
        }
        else {
            return toString(self.minutes);
        }
    }
    
    public func GetTimePeriod() -> String {
        if (self.isAM) {
            return "AM"
        }
        else {
            return "PM"
        }
    }
    
}
*/