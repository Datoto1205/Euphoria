//
//  noteViewController.swift
//  Euphoria
//
//  Created by Li Cheng-En in 2018.
//  Copyright © 2018 Li Cheng-En. All rights reserved.
//

import UIKit
import CoreData

class noteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var noteTable: UITableView!
    @IBOutlet weak var addText: UITextField!
    @IBOutlet weak var upView: positionView!
    
    @IBAction func addButtom(_ sender: UIButton) {
        if addText.isEditing == false {
            
        } else if addText.text == "" {
            
        } else if addText.text != "" {
            addMoreWork()
            addText.text = ""
            addText.endEditing(true)
        }
    }
    
    var worksListArray: [String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTable.delegate = self
        noteTable.dataSource = self
        // I need to add these two rows if I want to add tableVIew in the general viewController.
        
        addText.delegate = self
        // I need to declare "UITextFieldDelegate" and the code above if I want to do something concerning UITextField.
        
        fetchHistoricalWorks()
        deleteHistoricalWorks()
        upView.contentViewText.text = "Go to work!"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveTheWork()
    }
    
    func addMoreWork() {
        // Add more element into the array.
        worksListArray.append(addText.text!)
        
        // Update the tableView.
        let indexPath = IndexPath(row: worksListArray.count - 1, section: 0)
        noteTable.beginUpdates()
        noteTable.insertRows(at: [indexPath], with: .automatic)
        noteTable.endUpdates()
    }
    
    
    
    // Clear the textField when the user start to type.
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.isEditing == true {
            textField.text = ""
        }
    }
    
    
    
    
    
    //------------<Below are functions concerning the properties of tableView>------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return worksListArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "singleNote", for: indexPath)
        cell.textLabel?.text = worksListArray[indexPath.row]
        
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Works"
    }
    //------------<Above are functions concerning the properties of tableView>------------
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    
    // Enable the functions of deleting the rows
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            worksListArray.remove(at: indexPath.row)
            
            noteTable.beginUpdates()
            noteTable.deleteRows(at: [indexPath], with: .automatic)
            noteTable.endUpdates()
        }
    }
    
    
    
    
    
    //------------<Below are functions concerning the CoreData>------------
    func saveTheWork() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let Context = appDelegate.persistentContainer.viewContext
        
        let Entity = NSEntityDescription.entity(forEntityName: "Table", in: Context)
        let newWork = NSManagedObject(entity: Entity!, insertInto: Context)
        
        newWork.setValue(worksListArray, forKey: "works")
        
        do {
            try Context.save()
        } catch {
            print("Failed to save the new data of works.")
        }
    }
    
    func fetchHistoricalWorks() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let Context = appDelegate.persistentContainer.viewContext
        let myRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Table")
        myRequest.returnsObjectsAsFaults = false
        
        do {
            let finalresult = try Context.fetch(myRequest)
            for data in finalresult as! [NSManagedObject] {
                let historicalWorksIFetched: [String] = data.value(forKey: "works")! as! [String]
                worksListArray = historicalWorksIFetched
            }
        } catch {
            print("Could not fetch the works before.")
        }
    }
    
    func deleteHistoricalWorks() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Table"))
        do {
            try managedContext.execute(DelAllReqVar)
        }
        catch {
            print("Could not delete the old data of works.")
        }
    }
    //------------<Above are functions concerning the CoreData>------------
}
