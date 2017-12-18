//
//  Price.swift
//  SocketIOTest
//
//  Created by Chhaileng Peng on 12/16/17.
//  Copyright © 2017 Chhaileng Peng. All rights reserved.
//

import Foundation

class Price {
    var price: Double?
    
    init() {
        price = 0
    }
    
    init(price: Double) {
        self.price = price
    }
}
