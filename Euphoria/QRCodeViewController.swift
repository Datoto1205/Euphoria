//
//  QRCodeViewController.swift
//  Euphoria
//
//  Created by 李政恩 on 10/08/2018.
//  Copyright © 2018 李政恩. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var video = AVCaptureVideoPreviewLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        metadataInput()
        
        drawARectOfQRScope()
        addInstructionLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func metadataInput() {
        let session = AVCaptureSession()
        
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        } catch {
            print("Error")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        session.startRunning()
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects != nil && metadataObjects.count != 0 {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if object.type == AVMetadataObject.ObjectType.qr {
                    
                    let notification = Notification.Name("Charge")
                    NotificationCenter.default.post(name: notification, object: nil)
                    
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }

    
    
    func drawARectOfQRScope() {
        let linePath = UIBezierPath.init(rect: CGRect.init(x: view.center.x - 100, y: view.center.y - 100, width: 200, height: 200))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect.init(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        shapeLayer.path = linePath.cgPath
        shapeLayer.lineWidth = 2
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        self.view.layer.addSublayer(shapeLayer)
        
    }
    
    func addInstructionLabel() {
    let textOfSubViewA = UILabel()
    textOfSubViewA.frame = CGRect(x: view.bounds.minX + 20, y: view.bounds.maxY - 120, width: view.bounds.width - 40, height: 60)
    textOfSubViewA.text = "Please scan any valid QR Code to charge your balance!"
    textOfSubViewA.numberOfLines = 2
    textOfSubViewA.textAlignment = NSTextAlignment.center
    textOfSubViewA.textColor = UIColor.black
    
    self.view.addSubview(textOfSubViewA)
    }
    
    // Tutorials I refer to: https://www.youtube.com/watch?v=4Zf9dHDJ2yU and https://www.jianshu.com/p/9735421b94d1
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
