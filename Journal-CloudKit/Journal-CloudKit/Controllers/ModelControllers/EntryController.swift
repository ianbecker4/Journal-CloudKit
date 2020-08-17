//
//  EntryController.swift
//  Journal-CloudKit
//
//  Created by Ian Becker on 8/17/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import Foundation
import CloudKit

class EntryController {
    
    // MARK: - Shared Instance
    static let sharedInstance = EntryController()
    
    // MARK: - Source of Truth
    var entries: [Entry] = []
    
    // MARK: - Properties
    let privateDB = CKContainer.default().privateCloudDatabase
    
    // MARK: - Functions
    
    func saveEntry(with title: String, bodyText: String, completion: @escaping (Result<Entry?, EntryError>) -> Void) {
        
        let newEntry = Entry(title: title, bodyText: bodyText)
        
        let entryRecord = CKRecord(entry: newEntry)
        
        privateDB.save(entryRecord) { (record, error) in
            
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            
            guard let record = record,
                let savedEntry = Entry(ckRecord: record)
                else { return completion(.failure(.couldNotUnwrap))}
            
            print("Saved Entry successfully.")
            
            completion(.success(savedEntry))
        }
    }
    
    func fetchAllEntries(completion: @escaping (Result<[Entry]?, EntryError>) -> Void) {
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: EntryStrings.recordTypeKey, predicate: predicate)
        
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            
            guard let records = records else { return completion(.failure(.couldNotUnwrap))}
            
            print("Successfully fetched all Entries")
            
            let entries =  records.compactMap({ Entry(ckRecord: $0) })
            
            self.entries = entries
            
            completion(.success(entries))
        }
    }
} // End of class

