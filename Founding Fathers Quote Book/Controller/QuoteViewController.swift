//
//  QuoteViewController.swift
//  Founding Fathers Quote Book
//
//  Created by Nick Mahe on 9/11/19.
//  Copyright © 2019 Nick Mahe. All rights reserved.
//

import UIKit
import WebKit

class QuoteViewController : UIViewController {
    
    //Constants
    private struct Storyboard{
        static let quoteOfTheDayTitle = "Quote of the Day"
        static let showTopicsSegueIdentifier = "ShowTopics"
        static let todayTitle = "Today"
        static let topicsTitle = "Topics"
    }
    
    //Properties
    var currentQuoteIndex = 0
    var quotes: [Quote]!
    var topic: String?
    //Outlets
    
    @IBOutlet weak var toggleButton: UIBarButtonItem!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    
    //Actions
    
    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left{
            currentQuoteIndex -= 1
            if currentQuoteIndex < 0{
                currentQuoteIndex = quotes.count - 1
            }
            else{
                currentQuoteIndex += 1
                if currentQuoteIndex >= quotes.count{
                    currentQuoteIndex = 0
                }
            }
        }
        
        updateUIByToggling()
    }
    
    @IBAction func toggleTopics(_ sender: UIBarButtonItem) {
        if sender.title == Storyboard.topicsTitle{
            performSegue(withIdentifier: Storyboard.showTopicsSegueIdentifier, sender: sender)
        }
        else{
            showQuoteOfTheDay()
        }
    }
    private func chooseQuoteOfTheDay(){
        let formatter = DateFormatter()
        
        formatter.dateFormat = "DDD"
        
        if let dayInYear = Int(formatter.string(from: Date())){
            currentQuoteIndex = dayInYear % QuoteDeck.sharedInstance.quotes.count
        }
    }
    
    private func configure(){
        
        if let currentTopic = topic{
            currentQuoteIndex = 0
            quotes = QuoteDeck.sharedInstance.quotes(for: currentTopic)
            
        }
        
        else{
            quotes = QuoteDeck.sharedInstance.quotes
            chooseQuoteOfTheDay()
            
        }
        
        updateUI()
    }
    func showQuoteOfTheDay(){
        topic = nil
        configure()
    }
    
    private func title(for topic:String) -> String{
        return "\(topic.capitalized) \(currentQuoteIndex + 1) of \(quotes.count)"
    }
    
    
    private func updateUI(){
        let currentQuote = quotes[currentQuoteIndex]
        
        if let currentTopic = topic{
            title = title(for: currentTopic)
            toggleButton.title = Storyboard.todayTitle
        }
        else{
            title = Storyboard.quoteOfTheDayTitle
            toggleButton.title = Storyboard.topicsTitle
        }
        
        webView.loadHTMLString(currentQuote.html, baseURL : nil)
    }
    private func updateUIByToggling(){
        let quote = quotes[currentQuoteIndex]
        if let currentTopic = topic {
            let fadeTextAnimation = CATransition()
            
            fadeTextAnimation.duration = 0.75
            fadeTextAnimation.type = .fade
            
            navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: "fadeText")
            navigationItem.title = title(for: currentTopic)
        }
        
        webView.evaluateJavaScript("toggleQuote('\(quote.text)', '\(quote.speaker)')")
    }
    
    @IBAction func exitModalScene(_ segue: UIStoryboardSegue){
        //In this case, there is nothing to do, but we need a target
        topic = nil
        configure()
    }
    @IBAction func showTopicQuotes(_ segue: UIStoryboardSegue){
        configure()
    }
}
