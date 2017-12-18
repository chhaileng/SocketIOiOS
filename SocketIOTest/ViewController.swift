//
//  ViewController.swift
//  SocketIOTest
//
//  Created by Chhaileng Peng on 12/15/17.
//  Copyright © 2017 Chhaileng Peng. All rights reserved.
//

import UIKit
import SocketIO
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    var socket = SocketIOClient(socketURL: URL(string: "http://127.0.0.1:9090")!, config:[.log(false), .forceWebsockets(true), .nsp("/auction")])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        socket.connect()
        
        socket.on(clientEvent: .connect) { data, ack in
            print("Connected to Socket server")
            self.statusLabel.text = "Connected"
            self.statusLabel.textColor = UIColor.blue
        }
        
        socket.on("disconnect") { data, ack in
            print("Disconnected from Socket server")
            self.statusLabel.text = "Not Connected"
            self.statusLabel.textColor = UIColor.red
        }
      
        socket.on("onBid") { data, ack in
            let price = Price()
            let dic = data[0] as! [String:AnyObject]
            price.price = dic["price"] as? Double
            self.label.text = "Price $ \(price.price!)"
            self.priceTextField.text = "\(price.price! + 1)"
        }

    }
    
    @IBAction func bidButton(_ sender: UIButton) {
        let p = Double(priceTextField.text!) ?? 0
        
        let data: [String:AnyObject] = ["price": p as AnyObject]
        
        self.label.text = "Price $ \(p)"
        self.priceTextField.text = "\(p + 1)"
        
        socket.emit("userBid", data)
    }
    
}

