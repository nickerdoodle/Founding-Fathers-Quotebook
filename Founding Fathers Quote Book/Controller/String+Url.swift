//
//  String+Url.swift
//  Founding Fathers Quote Book
//
//  Created by Nick Mahe on 9/30/19.
//  Copyright © 2019 Nick Mahe. All rights reserved.
//

import Foundation

extension String {
    var url: URL? {
        return URL(string: self)
    }
}
