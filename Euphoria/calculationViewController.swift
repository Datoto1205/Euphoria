//
//  calculationViewController.swift
//  Euphoria
//
//  Created by Li Cheng-En in 2018.
//  Copyright © 2018 Li Cheng-En. All rights reserved.
//

import UIKit

class calculationViewController: UIViewController {
    
    @IBOutlet weak var amountOfRMB: UILabel!
    @IBOutlet weak var amountIHaveTyped: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        // This function is used to detect the shaking of the device.
        
        if motion == .motionShake {
            amountOfRMB.text = String(round(4.4 * (Double(amountIHaveTyped.text!))!))
            amountIHaveTyped.endEditing(true)
        }
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
