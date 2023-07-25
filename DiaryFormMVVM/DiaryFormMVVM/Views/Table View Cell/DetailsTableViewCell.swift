//
//  DetailsTableViewCell.swift
//  DiaryFormMVVM
//
//  Created by Danmark Arqueza on 7/24/23.
//

import UIKit

class DetailsTableViewCell: UITableViewCell, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    let screenWidth = UIScreen.main.bounds.width
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var areaTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var tagsTextField: UITextField!
    
    var areaPickerView = UIPickerView()
    var taskCategoryPickerView = UIPickerView()
    private lazy var datePickerView: UIDatePicker = {
      let datePicker = UIDatePicker(frame: .zero)
      datePicker.datePickerMode = .date
      datePicker.timeZone = TimeZone.current
      return datePicker
    }()


    let areaOptions = ["Option 1", "Option 2", "Option 3"]
    let taskCategoryOptions = ["Task 1", "Task 2", "Task 3"]

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        areaPickerView.dataSource = self
        areaPickerView.delegate = self
        areaTextField.inputView = areaPickerView
        areaTextField.inputAccessoryView = createToolbar(with: #selector(doneButtonTappedForArea))

        taskCategoryPickerView.dataSource = self
        taskCategoryPickerView.delegate = self
        categoryTextField.inputView = taskCategoryPickerView
        categoryTextField.inputAccessoryView = createToolbar(with: #selector(doneButtonTappedForTaskCategory))
        
        datePickerView = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 200))
        datePickerView.datePickerMode = .date
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        dateTextField.inputView = datePickerView
        dateTextField.inputAccessoryView = createToolbar(with: #selector(doneButtonTappedForDate))
        
        if #available(iOS 14, *) {
            datePickerView.preferredDatePickerStyle = .wheels
        }
    }
    
    @objc func doneButtonTappedForArea() {
        areaTextField.resignFirstResponder()
    }

    @objc func doneButtonTappedForTaskCategory() {
        categoryTextField.resignFirstResponder()
    }

    @objc func doneButtonTappedForDate() {
        dateTextField.resignFirstResponder()
    }

    func createToolbar(with selector: Selector) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.tintColor = .black
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: selector)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true

        return toolbar
    }

    
    @objc func datePickerValueChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.dateFormat = "yyyy-MM-dd" // Choose your desired date format
        dateTextField.text = dateFormatter.string(from: datePickerView.date)
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == areaPickerView {
            return areaOptions.count
        } else if pickerView == taskCategoryPickerView {
            return taskCategoryOptions.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == areaPickerView {
            return areaOptions[row]
        } else if pickerView == taskCategoryPickerView {
            return taskCategoryOptions[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == areaPickerView {
            areaTextField.text = areaOptions[row]
        } else if pickerView == taskCategoryPickerView {
            categoryTextField.text = taskCategoryOptions[row]
        }
    }
    
    
    
}

