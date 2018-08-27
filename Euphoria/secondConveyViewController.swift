//
//  secondConveyViewController.swift
//  Euphoria
//
//  Created by Li Cheng-En in 2018.
//  Copyright © 2018 Li Cheng-En. All rights reserved.
//

import UIKit

class secondConveyViewController: UIViewController {
    
    @IBAction func transferData(_ sender: UIButton) {
        transferString = mom.text
        generateNotification()
        
        // Go back to previous page
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var girlfriendInSecondPage: UILabel!
    @IBOutlet weak var mom: UITextField!
    
    var AInSecondPage: String?
    var transferString: String?
    
    
    
    func generateNotification() {
        let notification = Notification.Name("motherName")
        NotificationCenter.default.post(name: notification, object: nil, userInfo: ["PASS": transferString])
        // If I want to use notification to transfer the data, I need to set a post to generate the notification afterward. If I could return to the page with observer, I could activate the function I want.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mom.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        //close the keyboard when pressed somewhere else on the screen
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Transfer the data throught the function "performSegue"
        girlfriendInSecondPage.text = "Your girlfriend is " + AInSecondPage!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
