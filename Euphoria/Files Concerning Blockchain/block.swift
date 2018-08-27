//
//  block.swift
//  Euphoria
//
//  Created by Li Cheng-En in 2018.
//  Copyright © 2018 Li Cheng-En. All rights reserved.
//

import Foundation

class Block {
    var hash: String!
    var data: String!
    var previousHash: String!
    var index: Int!
    
    func generateHash() -> String {
        return NSUUID().uuidString.replacingOccurrences(of: "-", with: "")
    }
    // "NSUUID().uuidString" could be used to generate a series of code with 32 characters.
}
// This class is one of three classes which were used to create the blockchain.
