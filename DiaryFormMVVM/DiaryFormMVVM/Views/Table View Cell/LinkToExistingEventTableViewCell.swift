//
//  LinkToExistingEventTableViewCell.swift
//  DiaryFormMVVM
//
//  Created by Danmark Arqueza on 7/24/23.
//

import UIKit

class LinkToExistingEventTableViewCell: UITableViewCell {
    
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
        // Initialization code
        checkBoxButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc private func checkboxTapped() {
        isChecked = !isChecked
    }
    
    

}
