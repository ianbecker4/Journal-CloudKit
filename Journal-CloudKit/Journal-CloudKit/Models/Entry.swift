//
//  Entry.swift
//  Journal-CloudKit
//
//  Created by Ian Becker on 8/17/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import Foundation
import CloudKit

struct EntryStrings {
    static let recordTypeKey = "Entry"
    static let titleKey = "title"
    static let bodyTextKey = "bodyText"
    static let timestampKey = "timestamp"
} // End of struct

class Entry {
    
    let title: String
    let bodyText: String
    let timestamp: Date
    let ckRecordID: CKRecord.ID
    
    init(title: String, bodyText: String, timestamp: Date = Date(), ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString) ) {
        self.title = title
        self.bodyText = bodyText
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }
} // End of class

extension CKRecord {
    
    convenience init(entry: Entry) {
        self.init(recordType: EntryStrings.recordTypeKey, recordID: entry.ckRecordID)
        self.setValuesForKeys([
            EntryStrings.titleKey : entry.title,
            EntryStrings.bodyTextKey : entry.bodyText,
            EntryStrings.timestampKey : entry.timestamp
        ])
    }
} // End of extension


extension Entry {
    
    convenience init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryStrings.titleKey] as? String,
            let bodyText = ckRecord[EntryStrings.bodyTextKey] as? String,
            let timestamp = ckRecord[EntryStrings.timestampKey] as? Date
        else {return nil}
        
        self.init(title: title, bodyText: bodyText, timestamp: timestamp)
    }
} // End of exntension
