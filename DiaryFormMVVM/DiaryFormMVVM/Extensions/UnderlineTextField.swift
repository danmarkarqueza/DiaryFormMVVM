//
//  UnderlineTextField.swift
//  DiaryFormMVVM
//
//  Created by Danmark Arqueza on 7/24/23.
//

import UIKit

class UnderLineTextField: UITextField, UITextFieldDelegate {

    let border = CALayer()

    @IBInspectable open var lineColor: UIColor = UIColor.black {
        didSet {
            border.borderColor = lineColor.cgColor
        }
    }
    

    @IBInspectable open var dropdownIcon: UIImage? {
        didSet {
            updateRightView()
        }
    }

    @IBInspectable open var selectedLineColor: UIColor = UIColor.black {
        didSet {
            
        }
    }

    @IBInspectable open var lineHeight: CGFloat = CGFloat(1.0) {
        didSet {
            border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width: self.frame.size.width, height: self.frame.size.height)
        }
    }

    @IBInspectable open var placeholderText: String? {
        didSet {
            self.attributedPlaceholder = NSAttributedString(string: placeholderText ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        border.borderColor = lineColor.cgColor
        self.attributedPlaceholder = NSAttributedString(string: placeholderText ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])

        border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = lineHeight
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
        updateRightView()
    }

    override func draw(_ rect: CGRect) {
        border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width: self.frame.size.width, height: self.frame.size.height)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        border.frame = CGRect(x: 0, y: self.frame.size.height - lineHeight, width: self.frame.size.width, height: self.frame.size.height)
        self.delegate = self
    }
    
    // Function to update the rightView with the icon image
    private func updateRightView() {
       
        if let icon = dropdownIcon {
            let iconImageView = UIImageView(image: icon)
            iconImageView.contentMode = .center
            iconImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            iconImageView.tintColor = UIColor.lightGray
           
            self.rightView = iconImageView
            self.rightViewMode = .always
        } else {
           
            self.rightView = nil
            self.rightViewMode = .never 
        }
    }


    func textFieldDidBeginEditing(_ textField: UITextField) {
        border.borderColor = selectedLineColor.cgColor
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        border.borderColor = lineColor.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
}
