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
        static let showQuoteSegueIdentifier = "ShowQuote"
        static let topicCellIdentifier = "TopicCell"
    }
    
    //Properties
    var selectedTopic: String?
    
    //View Controller Lifecycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let quoteViewController = segue.destination as? QuoteViewController {
            quoteViewController.topic = selectedTopic
        }
    }
    
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
        selectedTopic = QuoteDeck.sharedInstance.tagSet[indexPath.row]
        performSegue(withIdentifier: Storyboard.showQuoteSegueIdentifier, sender: self)
    }
}
