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
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.loadHTMLString("""

                                <!DOCTYPE html>
                                <html lang="en">
                                <head>
                                    <meta charset="UTF-8">
                                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                    <title>Quote of the Day</title>
                                </head>
                                <body>
                                    <div style="font-size:24px;">
                                        Do you want to know who you are? Don't ask, Act!
                                    Action will delineate and define you.
                                <br /> Thomas Jefferson
                                    </div>
                                </body>
                                </html>

                            """, baseURL : nil)
    }
}
