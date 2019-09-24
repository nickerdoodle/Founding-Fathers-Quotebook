//
//  TopicsViewController.swift
//  Founding Fathers Quote Book
//
//  Created by Nick Mahe on 9/24/19.
//  Copyright © 2019 Nick Mahe. All rights reserved.
//

import UIKit

class TopicsViewController: UITableViewController{
    // Constant
    private struct Storyboard{
        static let topicCellIdentifier = "TopicCell"
    }
    
    //Properties
    
    
    //View Controller Lifecycle
    
    
    //Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.topicCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = QuoteDeck.sharedInstance.tagSet[indexPath.row].capitalized
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuoteDeck.sharedInstance.tagSet.count
    }
    
    //Table view delegate
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}
