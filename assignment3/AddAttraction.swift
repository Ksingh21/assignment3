//
//  AddAttraction.swift
//  assignment3
//
//  Created by Student on 2018-02-13.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

protocol AddAttractionVCDelegate: class {
    func addAttractionVCDidCancel()
    func addAttractionVC(_ control: AddAttraction, didFinishAdd attraction: AttractionItem)
    func addAttractionVC(_ control: AddAttraction, didFinishEdit attraction: AttractionItem)
}

class AddAttraction: UITableViewController, ChooseProvinceVCDelegate  {
    
    weak var delegate: AddAttractionVCDelegate?
    
    @IBOutlet weak var attractionName: UITextField!
    
    
    @IBOutlet weak var provinceIcon: UIImageView!
    
    @IBOutlet weak var cityName: UITextField!
    
    
    @IBOutlet weak var dueDateLabel: UILabel!
    
    @IBOutlet weak var datePickerSwitch: UISwitch!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var ratingSlider: UISlider!
    
    var attractionToEdit: AttractionItem?
    var iconName: String?
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        dueDateLabel.text = formatter.string(from: datePicker.date) 
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        tableView.reloadData()
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.addAttractionVCDidCancel()
    }
    @IBAction func done(_ sender: UIBarButtonItem) {
        if let attraction = attractionToEdit {
            attractionName.text = attractionName.text!
            if let icon = iconName {
                attraction.iconName = icon
            }
            delegate?.addAttractionVC(self, didFinishEdit: attraction)
        } else {
            let text = attractionName.text!
            let attraction = AttractionItem(attractionName: text, checked: false)
            if let icon = iconName {
                attraction.iconName = icon
            }
            delegate?.addAttractionVC(self, didFinishAdd: attraction)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let attraction = attractionToEdit {
            attractionName.text = attraction.attractionName
            self.title = "Edit Item"
            iconName = attraction.iconName
            if let iconName = iconName {
                provinceIcon.image = UIImage(named: iconName)
            }
        } else {
            title = "Add Item"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! ChooseProvince
        controller.delegate = self

    }
    
    func chooseProvince(_ controller: ChooseProvince, didPick iconName: String) {
        self.iconName = iconName
        provinceIcon.image = UIImage(named: iconName)
        navigationController?.popViewController(animated: true)
    }

}
