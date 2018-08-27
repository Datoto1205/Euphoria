//
//  blockChainViewController.swift
//  Euphoria
//
//  Created by Li Cheng-En in 2018.
//  Copyright © 2018 Li Cheng-En. All rights reserved.
//

import UIKit

class blockChainViewController: UIViewController{
    
    let accountNumber = 9487
    let cryptoCurrencyChain = blockChain()
    let reward = 1
    var account: [String: Int] = ["0000": 10000]
    var chainDetails: String!
    
    @IBOutlet weak var balance: UILabel!
    
    let invalidAllert = UIAlertController(title: "Invalid Transaction", message: "Please check the details of your transaction!", preferredStyle: .alert)
    let introductionAllert = UIAlertController(title: "Windfall Wallet", message: "This is an example of block chain which was created by Swift, please check the console in Xcode when you run this page to gain more details!", preferredStyle: .alert)
    
    
    
    func transaction(from: String, to: String, amount: Int, type: String) {
        //When the balance of sender is smaller than 0, sender could not send the money.
        if account[from] == nil {
            self.present(invalidAllert, animated: true, completion: nil)
            return
        } else if (account[from]! - amount) < 0 {
            self.present(invalidAllert, animated: true, completion: nil)
            return
        } else {
            account.updateValue(account[from]! - amount, forKey: from)
        }
        
        // When the balance of receiver is 0, the balance would increase immediately.
        if account[to] == nil {
            account.updateValue(amount, forKey: to)
        } else {
            account.updateValue(account[to]! + amount, forKey: to)
        }
        
        // Record detailed data in each block.
        if type == "genesis" {
            cryptoCurrencyChain.createGenesisBlock(data: "From: \(from); To: \(to); Amount: \(amount) cryptocurrency; Sender Balance: \(account[from]!); Receiver Balance: \(account[to]!)")
        } else if type == "normal" {
            cryptoCurrencyChain.createBlock(data: "From: \(from); To: \(to); Amount: \(amount) cryptocurrency; Sender Balance: \(account[from]!); Receiver Balance: \(account[to]!)")
        }
    }
    
    
    
    func chainState() {
        // Print the details of the whole block chain.
        for i in 0...cryptoCurrencyChain.chain.count - 1 {
            print("\tBlock: \(cryptoCurrencyChain.chain[i].index!); \n\tHash: \(cryptoCurrencyChain.chain[i].hash!); \n\tPrevious Hash: \(cryptoCurrencyChain.chain[i].previousHash!); \n\tData: \(cryptoCurrencyChain.chain[i].data!)\n")
        }
        
        print(chainValidity())
    }
    
    func chainValidity() -> String {
        // Check whether the block chain is valid; if the chain was modified, system would return error.
        var isChainValid = true
        if cryptoCurrencyChain.chain.count > 1 {
            for i in 1...cryptoCurrencyChain.chain.count - 1 {
                if cryptoCurrencyChain.chain[i].previousHash != cryptoCurrencyChain.chain[i-1].hash {
                    isChainValid = false
                }
            }
        }
        
        return "Chain is valid: \(isChainValid)\n"
    }
    
    
    
    @IBAction func mining(_ sender: Any) {
        transaction(from: "0000", to: "\(accountNumber)", amount: reward, type: "normal")
        print("New block mined by: \(accountNumber)")
        balance.text = String(Int(balance.text!)! + reward)
        chainState()
    }
    
    @IBAction func send(_ sender: Any) {
        if balance.text == "" {
            present(invalidAllert, animated: true, completion: nil)
        } else if Int(balance.text!)! <= 9 {
            present(invalidAllert, animated: true, completion: nil)
        } else {
            transaction(from: "\(accountNumber)", to: "0000", amount: 10, type: "normal")
            print("10 Coins were returned to the God!")
            chainState()
            balance.text = String(Int(balance.text!)! - 10)
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.invalidAllert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.introductionAllert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(introductionAllert, animated: true, completion: nil)   /* Show the specific UIAllertView. */
        transaction(from: "0000", to: "\(accountNumber)", amount: 10, type: "genesis")
        balance.text = "10"
        chainState()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Tutorial I referred to: http://www.cocoachina.com/blockchain/20180822/24654.html
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
// This class is one of three classes which were used to create the blockchain.
