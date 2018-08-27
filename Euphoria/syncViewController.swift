//
//  syncViewController.swift
//  Euphoria
//
//  Created by Li Cheng-En in 2018.
//  Copyright © 2018 Li Cheng-En. All rights reserved.
//

import UIKit

class syncViewController: UIViewController {
    
    @IBOutlet weak var workResult: UILabel!
    @IBOutlet weak var introduction: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    
    
    @IBAction func sync(_ sender: Any) {
        DispatchQueue.main.async {
            for i in 1...10 {
                print(i)
            }
        }
        
        DispatchQueue.main.async {
            for i in (1...9).reversed() {
                print(i)
            }
        }
        
        let delayTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {self.workResult.text = "done"})
        
        self.introduction.text = "Use \"DispatchQueue.main.async\" to make works be done orderly."
    }
    
    
    
    @IBAction func async(_ sender: Any) {
        let work1 = {
            for i in 1...100 {
                print("Work 1 has been conducted for " + String(i) + " time!")
            }
        }
        
        let work2 = {
            for i in 1...100 {
                print("Work 2 has been conducted for " + String(i) + " time!")
            }
        }
        
        let globalQueue = DispatchQueue.global()
        globalQueue.async(execute: work1)
        globalQueue.async(execute: work2)
        globalQueue.sync {
            workResult.text = "Please check the console in Xcode to see the result of Asynchronously!"
        }
        
        self.introduction.text = "Use \"DispatchQueue.global().async\" to make works be done randomly."
    }
    
    
    
    @IBAction func asyncAfter(_ sender: Any) {
        let delayTime = DispatchTime.now() + .seconds(2)
        DispatchQueue.global().asyncAfter(deadline: delayTime, execute: {
            print("The work was done later!")
        })
        
        DispatchQueue.main.async {
            self.workResult.text = "Please check the console in Xcode to see the result of Asynchronously After!"
        }
        
        self.introduction.text = "Use \"DispatchQueue.global().asyncAfter\" to make works be done randomly and postpone some works."
    }
    
    
    
    @IBAction func serialQueue(_ sender: Any) {
        let work4 = {
            for i in 1...50 {
                print("Work 4 has been conducted for " + String(i) + " time!")
            }
        }
        
        let work5 = {
            for i in 1...60 {
                print("Work 5 has been conducted for " + String(i) + " time!")
            }
        }
        
        let createdSerialQueue1 = DispatchQueue(label: "queue1")
        let createdSerialQueue2 = DispatchQueue(label: "queue2")
        createdSerialQueue1.async(execute: work4)
        createdSerialQueue2.async(execute: work5)
        
        self.introduction.text = "Use \"DispatchQueue(label)\" to create several queues manually and make works be done randomly."
    }
    
    
    
    @IBAction func downloadImage(_ sender: Any) {
        let createdSerialQueue1 = DispatchQueue(label: "queue1")
        let createdSerialQueue2 = DispatchQueue(label: "queue2")
        
        createdSerialQueue1.async {
            let downloadImage1 = self.downloadPics(url: "http://t.wallpaperweb.org/wallpaper/buildings/2560x1600/ws_Pittsburg_Downtown_2560x1600.jpg")
            DispatchQueue.main.async {
                self.image1.image = downloadImage1
            }
        }
        
        createdSerialQueue2.async {
            let downloadImage2 = self.downloadPics(url: "https://inassets1-internationsgmbh.netdna-ssl.com/image/static_2048_1152/static/bundles/internationsseo/frontend/images/localcommunityHero/189.jpg")
            DispatchQueue.main.async {
                self.image2.image = downloadImage2
            }
        }
        
        self.introduction.text = "Use several serial queues to do the works of downloading the picture so that the user still could click other buttons during the process."
        self.workResult.text = "The left one is the city I stayed, the right one is the city I love."
        
        /*DispatchQueue.main.async(execute: {
         let downloadImage1 = self.downloadPics(url: "http://t.wallpaperweb.org/wallpaper/buildings/2560x1600/ws_Pittsburg_Downtown_2560x1600.jpg")
         let downloadImage2 = self.downloadPics(url: "https://inassets1-internationsgmbh.netdna-ssl.com/image/static_2048_1152/static/bundles/internationsseo/frontend/images/localcommunityHero/189.jpg")
         
         
         self.image1.image = downloadImage1
         self.image2.image = downloadImage2
         })*/
        // If I use the codes above, my screen would be just like fixed, and the user could not do anything else until the device finish the work of downloading the pictures.
    }
    
    
    
    func downloadPics(url: String) -> UIImage {
        let data = try? Data(contentsOf: URL(string: url)!)
        return UIImage(data: data!)!
        // This function was ritten by some unknown friends on the internet.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let introductionAllert = UIAlertController(title: "Demo of Queues", message: "This is an example of several different ways about queue, please check the console in Xcode when you run this page to gain more details!", preferredStyle: .alert)
        introductionAllert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(introductionAllert, animated: true, completion: nil)
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
