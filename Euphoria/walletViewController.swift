//
//  walletViewController.swift
//  Euphoria
//
//  Created by Li Cheng-En in 2018.
//  Copyright © 2018 Li Cheng-En. All rights reserved.
//

import UIKit

class walletViewController: UIViewController {
    
    @IBOutlet weak var walletAmount: UILabel!
    @IBOutlet weak var gradientButton: UIButton!
    
    @IBAction func gradientButtomAction(_ sender: Any) {
        position = "I have gotton the premium!"
        editUILabelThroughCode()
    }
    
    
    
    var amount: Int = 0
    var addValue: Bool = true
    var gradientBackgroundColor: CAGradientLayer!
    var alreadyGotThePremium: Bool = false
    var position: String = "I have not gotton the premium yet."
    var changeTheWord: Bool = false
    var firstWordWasChanged: Bool? = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        walletAmount.text = "￥  " + String(amount)
        
        generateNotificationForTransferingTheData()
        generateUIViewThroughCode()
        createDecorationButtom()
        editUILabelThroughCode()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        addValue = true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
        // This code, which could transfer the color code to the RGB type, was found from https://stackoverflow.com/questions/24074257/how-can-i-use-uicolorfromrgb-in-swift
    }
    
    func generateNotificationForTransferingTheData() {
        let notification = Notification.Name("Charge")
        NotificationCenter.default.addObserver(self, selector: #selector(getUpdateNoti(noti:)), name: notification, object: nil)
        // I want to transfer the data through notification, so I need to add this code.
    }
    
    @objc func getUpdateNoti(noti:Notification) {
        if addValue == true {
            amount = amount + 100
            walletAmount.text = "￥  " + String(amount)
            addValue = false
        }
    }
    
    
    
    func editUILabelThroughCode() {
        let textOfSubViewA = UILabel()
        textOfSubViewA.frame = CGRect(x: view.bounds.minX + 20, y: view.center.y + 15, width: view.bounds.width - 40, height: 30)
        textOfSubViewA.text = position
        textOfSubViewA.numberOfLines = 0
        textOfSubViewA.textAlignment = NSTextAlignment.center
        textOfSubViewA.textColor = UIColor.black
        textOfSubViewA.tag = 1   /* In order to distinguish the subView. */
        
        let textOfSubViewB = UILabel()
        textOfSubViewB.frame = CGRect(x: view.bounds.minX + 20, y: view.center.y + 15, width: view.bounds.width - 40, height: 30)
        textOfSubViewB.text = position
        textOfSubViewB.numberOfLines = 0
        textOfSubViewB.textAlignment = NSTextAlignment.center
        textOfSubViewB.textColor = UIColor.black
        textOfSubViewB.tag = 2   /* In order to distinguish the subView. */
        
        // I could use the codes below to add and remove the subview.
        if changeTheWord == false && firstWordWasChanged == false{
            view.addSubview(textOfSubViewA)
            changeTheWord = true
        } else if changeTheWord == true && firstWordWasChanged == false{
            if let viewWithTag = self.view.viewWithTag(1) {
                viewWithTag.removeFromSuperview()
                changeTheWord = false
                firstWordWasChanged = true
            }
        }
        
        // Update the anount of balance.
        if firstWordWasChanged == true {
            view.addSubview(textOfSubViewB)
            amount = amount + 10
            walletAmount.text = "￥  " + String(amount)
            firstWordWasChanged = nil
        }
    }
    
    func generateUIViewThroughCode() {
        let subViewA = UIView(frame: CGRect(x: 20, y: view.center.y - 20, width: view.bounds.width - 40, height: 100))
        subViewA.backgroundColor = hexStringToUIColor(hex: "#FFEFBA")
        view.addSubview(subViewA)
        // I could use this code to create a UIView through codes.
    }
    
    func createDecorationButtom() {
        gradientButton.layer.cornerRadius = 25
        gradientButton.layer.masksToBounds = true
        gradientButton.setTitle("Get The Premium", for: .normal)
        gradientButton.setTitleColor(UIColor.white, for: .normal)
        // Font property is deprecated after swift 3.0.
        
        let cgcolorA = UIColor(red: 0/255, green: 242/255, blue: 96/255, alpha: 1).cgColor
        let cgcolorB = UIColor(red: 5/255, green: 117/255, blue: 230/255, alpha: 1).cgColor
        self.gradientButton.applyGradient(colors: [cgcolorA, cgcolorB])
        // I could add a gradient color to a button through the codes above and the codes in the extension below.
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





extension UIButton {
    func applyGradient(colors: [CGColor])
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
    }
}
