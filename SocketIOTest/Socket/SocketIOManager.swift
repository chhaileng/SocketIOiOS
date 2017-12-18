//
//  SocketIOManager.swift
//  SocketIOTest
//
//  Created by Chhaileng Peng on 12/16/17.
//  Copyright © 2017 Chhaileng Peng. All rights reserved.
//

import UIKit
import SocketIO

let socketUrl = "http://127.0.0.1:9090"

class SocketIOManager: NSObject {
    
    static let shared = SocketIOManager()
    
    var socket = SocketIOClient(socketURL: URL(string: socketUrl)!, config:[.log(false), .forceWebsockets(true), .nsp("/auction")])
    
    override init() {
        super.init()
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func bid(_ price: Price){
        var b = [String:AnyObject]()
        b["price"] = price.price as AnyObject?
        socket.emit("userBid", b)
    }

}
