//
//  DetailsTableViewCell.swift
//  DiaryFormMVVM
//
//  Created by Danmark Arqueza on 7/24/23.
//

import UIKit

class DetailsTableViewCell: UITableViewCell, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var areaTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var tagsTextField: UITextField!
    
    // Create a UIPickerView instance
    private let pickerView = UIPickerView()
    
    // Create a UIDatePicker instance
    private let datePicker = UIDatePicker()
    
    // Create arrays for area and task category options
    let areaOptions = ["Option 1", "Option 2", "Option 3"] // Add your area options here
    let taskCategoryOptions = ["Task 1", "Task 2", "Task 3"] // Add your task category options here

    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set the text field delegates to self
        dateTextField.delegate = self
        areaTextField.delegate = self
        categoryTextField.delegate = self
        
        dateTextField.tag = 1
        areaTextField.tag = 2
        categoryTextField.tag = 3

        // Set the input view of the text fields to the pickerView
        // Set the input view of the date text field to the datePicker
        dateTextField.inputView = datePicker
        areaTextField.inputView = pickerView
        categoryTextField.inputView = pickerView

        // Configure the picker view
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Configure the date picker
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
     
    }
    
    // Action method to handle date picker value changes
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Choose your desired date format
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Number of components in the picker view (always 1 for single column)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if (pickerView.tag == 1) {
            
        } else if (pickerView.tag == 2) {
            return 1
        } else if (pickerView.tag == 3) {
            return 1
        }
        
        return 0
    }
    
    // Number of rows in the picker view (depends on the text field)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 2 {
            return areaOptions.count
        } else if pickerView.tag == 3 {
            return taskCategoryOptions.count
        }
        return 0
    }
    
    // Title for each row in the picker view (depends on the text field)
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 2 {
            return areaOptions[row]
        } else if pickerView.tag == 3 {
            return taskCategoryOptions[row]
        }
        return nil
    }

    // Handle the selection of a row in the picker view (set the text field's text)
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 2 {
            areaTextField.text = areaOptions[row]
        } else if pickerView.tag == 3 {
            categoryTextField.text = taskCategoryOptions[row]
        }
    }
    
}

