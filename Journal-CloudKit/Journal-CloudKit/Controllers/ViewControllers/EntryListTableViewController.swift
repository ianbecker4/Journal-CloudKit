//
//  EntryListTableViewController.swift
//  Journal-CloudKit
//
//  Created by Ian Becker on 8/17/20.
//  Copyright © 2020 Ian Becker. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EntryController.sharedInstance.fetchAllEntries { (result) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.sharedInstance.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        let entry = EntryController.sharedInstance.entries[indexPath.row]
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.timestamp.formatDate()

        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
    }
}
