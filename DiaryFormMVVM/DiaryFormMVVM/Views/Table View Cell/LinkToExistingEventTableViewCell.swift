//
//  LinkToExistingEventTableViewCell.swift
//  DiaryFormMVVM
//
//  Created by Danmark Arqueza on 7/24/23.
//

import UIKit

class LinkToExistingEventTableViewCell: UITableViewCell, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let eventOptions = ["Event 1", "Event 2", "Event 3"]
    
    var eventPickerView = UIPickerView()
    
    @IBOutlet weak var eventTextField: UnderLineTextField!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    var checkedImage: UIImage? = UIImage(systemName: "checkmark.square.fill") {
        didSet {
            updateCheckboxImage()
        }
    }

    var uncheckedImage: UIImage? = UIImage(systemName: "square") {
        didSet {
            updateCheckboxImage()
        }
    }
    
    var isChecked: Bool = false {
        didSet {
            updateCheckboxImage()
        }
    }


    private func updateCheckboxImage() {
        let checkboxImage = isChecked ? checkedImage : uncheckedImage
        checkBoxButton.setImage(checkboxImage, for: .normal)
        checkBoxButton.tintColor = isChecked ? .colorWithRGBHex(0xFFA4D541) : .lightGray
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        checkBoxButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        eventPickerView.dataSource = self
        eventPickerView.delegate = self
        eventTextField.inputView = eventPickerView
        eventTextField.inputAccessoryView = createToolbar(with: #selector(doneButtonTappedForArea))
    }
    
    @objc func doneButtonTappedForArea() {
        eventTextField.resignFirstResponder()
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc private func checkboxTapped() {
        isChecked = !isChecked
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return eventOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return eventOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        eventTextField.text = eventOptions[row]
    }
    

}
