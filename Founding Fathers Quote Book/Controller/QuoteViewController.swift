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
    //Properties
    var currentQuoteIndex = 0
    
    //Outlets
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseQuoteOfTheDay()
        updateUI()
        
        
    }
    private func chooseQuoteOfTheDay(){
        let formatter = DateFormatter()
        
        formatter.dateFormat = "DDD"
        
        if let dayInYear = Int(formatter.string(from: Date())){
            currentQuoteIndex = dayInYear % QuoteDeck.sharedInstance.quotes.count
        }
    }
    
    private func updateUI(){
        let currentQuote = QuoteDeck.sharedInstance.quotes[currentQuoteIndex]
        webView.loadHTMLString(currentQuote.html, baseURL : nil)
    }
    @IBAction func exitModalScene(_ segue: UIStoryboardSegue){
        //In this case, there is nothing to do, but we need a target
    }
}
