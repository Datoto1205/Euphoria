//
//  firstConveyViewController.swift
//  Euphoria
//
//  Created by 李政恩 on 09/08/2018.
//  Copyright © 2018 李政恩. All rights reserved.
//

import UIKit

class firstConveyViewController: UIViewController {

    @IBOutlet weak var girlFriendName: UITextField!
    @IBOutlet weak var momName: UILabel!
    @IBAction func goToNextPage(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSecond", sender: self)
    }
    // I also could use the performSegue() function to move to next page.
    
    var AInFirstPage: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notification = Notification.Name("Hi")
        NotificationCenter.default.addObserver(self, selector: #selector(getUpdateNoti(noti:)), name: notification, object: nil)
        // If I want to use notification to transfer the data, I need to set a observer first, so that it would do the function I want, which is getUpdateNoti here, when it heard the notification generated in other pages.
    }
    
    @objc func getUpdateNoti(noti:Notification) {
        momName.text = "Your mom is " + (noti.userInfo!["PASS"] as! String)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        girlFriendName.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        //close the keyboard when pressed somewhere else on the screen
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // Transfer the data throught the function "performSegue"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        AInFirstPage = girlFriendName.text
        let controller = segue.destination as! secondConveyViewController
        controller.AInSecondPage = AInFirstPage /* I need to set the variable in second page first.*/
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
