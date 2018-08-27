//
//  blockChain.swift
//  Euphoria
//
//  Created by Li Cheng-En in 2018.
//  Copyright © 2018 Li Cheng-En. All rights reserved.
//

import Foundation

class blockChain {
    var chain = [Block]()
    
    func createGenesisBlock(data: String) {
        let genesisBlock = Block()
        genesisBlock.hash = genesisBlock.generateHash()
        genesisBlock.data = data
        genesisBlock.previousHash = "0000"
        genesisBlock.index = 0
        chain.append(genesisBlock)
    }
    
    func createBlock(data: String) {
        let newBlock = Block()
        newBlock.hash = newBlock.generateHash()
        newBlock.data = data
        newBlock.previousHash = chain[chain.count - 1].hash
        newBlock.index = chain.count
        chain.append(newBlock)
    }
}
// This class is one of three classes which were used to create the blockchain.
