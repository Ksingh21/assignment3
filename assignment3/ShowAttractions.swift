
//
//  ShowAttractions.swift
//  assignment3
//
//  Created by Student on 2018-02-13.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class ShowAttractions: UITableViewController, AddAttractionVCDelegate {
    
    var datamodel: Datamodel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        let attraction = AttractionItem(attractionName: "Hatley Castle", checked: true);
        let newRow = datamodel.attraction.count;
        datamodel.attraction.append(attraction)
        
        let indexPath = IndexPath(row: newRow, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datamodel.attraction.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = datamodel.attraction[indexPath.row].attractionName
        
        let visitedLabel = cell.viewWithTag(1001) as! UILabel
        visitedLabel.text = "√"
        
        let provinceIconName = datamodel.attraction[indexPath.row].iconName
        let imageView = cell.viewWithTag(1002) as! UIImageView
        imageView.image = UIImage(named:provinceIconName)
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            let visitedLabel = cell.viewWithTag(1001) as! UILabel
            if (visitedLabel.text == "√") {
                visitedLabel.text = ""
            } else {
                visitedLabel.text = "√"
            }
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "AddAttraction") {
            let controller = segue.destination as! AddAttraction
            controller.delegate = self
            
        } else if (segue.identifier == "EditAttraction") {
            let controller = segue.destination as! AddAttraction
            controller.delegate = self
            
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            let attraction = datamodel.attraction[indexPath!.row]
            controller.attractionToEdit = attraction
        }
    }
    
    func addAttractionVCDidCancel() {
        navigationController?.popViewController(animated: true)
    }
    
    func addAttractionVC(_ control: AddAttraction, didFinishAdd attraction: AttractionItem) {
        let newRow = datamodel.attraction.count;
        datamodel.attraction.append(attraction)
        
        let indexPath = IndexPath(row: newRow, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func addAttractionVC(_ control: AddAttraction, didFinishEdit attraction: AttractionItem) {
        if let index = datamodel.attraction.index(of: attraction) {
            datamodel.attraction[index].attractionName = attraction.attractionName
            datamodel.saveAttraction()
            
            let indexPath = IndexPath(row: index, section: 0)
            
            if let cell = tableView.cellForRow(at: indexPath) {
                let label = cell.viewWithTag(1000) as! UILabel
                label.text = attraction.attractionName
                let provinceIconName = datamodel.attraction[indexPath.row].iconName
                let imageView = cell.viewWithTag(1002) as! UIImageView
                imageView.image = UIImage(named:provinceIconName)
            }
        }
        navigationController?.popViewController(animated: true)
        
    }
}
