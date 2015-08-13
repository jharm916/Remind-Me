//
//  RemindMeModel.swift
//  Remind Me
//
//  Created by Jeremy Harman on 7/5/15.
//  Copyright (c) 2015 Jeremy Harman. All rights reserved.
//

import Foundation

class OperateModel {
    
    func AddItem(item: ListEntryInput, entryList: NSMutableArray) {
        var list = entryList
        entryList.addObject(item)
    }
    
}

