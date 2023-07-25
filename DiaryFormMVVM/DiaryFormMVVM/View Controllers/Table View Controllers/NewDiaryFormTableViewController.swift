//
//  NewDiaryFormTableViewController.swift
//  DiaryFormMVVM
//
//  Created by Danmark Arqueza on 7/24/23.
//

import UIKit

class NewDiaryFormTableViewController: UITableViewController {

    let viewModel = NewDiaryFormViewModel()
    
    private weak var loadingIndicator: UIActivityIndicatorView?
    private var successPopUpView: UIView!


    var selectedPhotos: [UIImage] = []
    var comment: String?
    var dateDetails: String?
    var area: String?
    var taskCategory: String?
    var tags: String?
    var event: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingIndicator()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.colorWithRGBHex(0xFFF2F5F7)
        tableView.separatorStyle = .none
        
        tableView.register(UINib(nibName: "AddPhotosCell", bundle: nil), forCellReuseIdentifier: "AddPhotosCell")
        tableView.register(UINib(nibName: "CommentsCell", bundle: nil), forCellReuseIdentifier: "CommentsCell")
        tableView.register(UINib(nibName: "DetailsCell", bundle: nil), forCellReuseIdentifier: "DetailsCell")
        tableView.register(UINib(nibName: "LinkToEventCell", bundle: nil), forCellReuseIdentifier: "LinkToEventCell")
    }
    
    private func setupLoadingIndicator() {
        let loadingIndicator = UIActivityIndicatorView(style: .medium)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.hidesWhenStopped = true
        view.addSubview(loadingIndicator)

        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        self.loadingIndicator = loadingIndicator
    }

    
    private func showSuccessPopUp() {
        let alertController = UIAlertController(title: "Success", message: "Diary successfully submitted!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    
    // Method to reset all text fields
    func resetTextFields() {
        // Access each cell and reset the text fields to empty strings
        if let addPhotosCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AddPhotosTableViewCell {
            addPhotosCell.selectedPhotos.removeAll()
            
        }

        if let commentsCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? CommentsTableViewCell {
            commentsCell.commentsTextField.text = ""
        }

        if let detailsCell = tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? DetailsTableViewCell {
            detailsCell.dateTextField.text = ""
            detailsCell.areaTextField.text = ""
            detailsCell.categoryTextField.text = ""
            detailsCell.tagsTextField.text = ""
        }
        
        if let eventsCell = tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? LinkToExistingEventTableViewCell {
            eventsCell.eventTextField.text = ""
        }
    }
    
    @objc func nextButtonTapped() {
        print("Selected photos count:", selectedPhotos.count)

        DispatchQueue.main.async {
            self.loadingIndicator?.startAnimating()
        }

        print("\(comment ?? "") \(dateDetails ?? "") \(area ?? "") \(taskCategory ?? "") \(tags ?? "") \(event ?? "")")

        var imagesBase64: [String] = []
        var convertedImagesCount = 0
        let totalImages = selectedPhotos.count

        // Use a dispatch group to wait for all conversions to complete
        let dispatchGroup = DispatchGroup()

        for image in selectedPhotos {
            dispatchGroup.enter()
            ImageUtils.convertImageToBase64(image: image) { base64String in
                if let base64String = base64String {
                    imagesBase64.append(base64String)
                }
                convertedImagesCount += 1
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            // All images are converted, proceed to create the diary request
            let diaryRequest = DiaryRequest(
                imagesBase64: imagesBase64,
                comments: self.comment ?? "",
                date: self.dateDetails ?? "",
                area: self.area ?? "",
                taskCategory: self.taskCategory ?? "",
                tags: self.tags ?? "",
                linkToExistingEvent: self.event ?? ""
            )

            self.viewModel.createDiaryRequest(diaryRequest: diaryRequest) { result in
                DispatchQueue.main.async {
                    self.loadingIndicator?.stopAnimating()
                }

                switch result {
                case .success(let diaryResponse):
                    DispatchQueue.main.async {
                        self.showSuccessPopUp()
                        self.resetTextFields()
                    }
                    print("Diary created: \(diaryResponse)")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
        
    }
}

extension NewDiaryFormTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddPhotosCell", for: indexPath) as! AddPhotosTableViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear.withAlphaComponent(0)
            
            self.selectedPhotos = cell.selectedPhotos
            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsTableViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear.withAlphaComponent(0)
            cell.commentsTextField.delegate = self
            return cell

        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsTableViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear.withAlphaComponent(0)
            
            cell.dateTextField.delegate = self
            cell.areaTextField.delegate = self
            cell.categoryTextField.delegate = self
            cell.tagsTextField.delegate = self
            // Configure the Details cell here
            return cell

        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LinkToEventCell", for: indexPath) as! LinkToExistingEventTableViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear.withAlphaComponent(0)
            
            cell.eventTextField.delegate = self
            return cell

        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 48))
            header.backgroundColor = UIColor.clear
            // Create the HeaderView
            let headerView = HeaderView()
            headerView.translatesAutoresizingMaskIntoConstraints = false
            header.addSubview(headerView)
            
            // Add constraints for the HeaderView at the top of the screen
            NSLayoutConstraint.activate([
                headerView.leadingAnchor.constraint(equalTo: header.leadingAnchor),
                headerView.trailingAnchor.constraint(equalTo: header.trailingAnchor),
                headerView.centerYAnchor.constraint(equalTo: header.centerYAnchor),
                headerView.heightAnchor.constraint(equalToConstant: 48)
            ])
            
            return header
        }

        return nil
        
    }
    
    // Implement the table view's viewForFooterInSection method to add the "Next" button
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            if section == numberOfSections(in: tableView) - 1 {
                // Create a custom view for the "Next" button
                let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 54))
                footerView.backgroundColor = UIColor.clear

                // Create the "Next" button and customize it as needed
                let nextButton = UIButton(type: .system)
                nextButton.setTitle("Next", for: .normal)
                nextButton.setTitleColor(UIColor.white, for: .normal)
                nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                nextButton.backgroundColor = UIColor.colorWithRGBHex(0xFFA4D541)
                nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
                nextButton.translatesAutoresizingMaskIntoConstraints = false
                footerView.addSubview(nextButton)
                
                // Set corner radius to give the button rounded corners
                nextButton.layer.cornerRadius = 10 // Adjust the value as needed for desired corner radius
                nextButton.layer.masksToBounds = true
                
                // Set up constraints for the "Next" button to center it within the footer view
                NSLayoutConstraint.activate([
                    nextButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 10),
                                nextButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -10),
                                nextButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
                                nextButton.heightAnchor.constraint(equalToConstant: 54)
                ])

                return footerView
            }

            return nil
        }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 48
        }

        return 0.01
    }
    

    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == numberOfSections(in: tableView) - 1 {
        }

        return 0.01 
    }



    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 350
        } else if indexPath.section == 1 {
            return 180
        } else if indexPath.section == 2 {
            return 350
        } else if indexPath.section == 3 {
            return 190
        }
        return 200

        
    }
}



extension NewDiaryFormTableViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let indexPath = tableView.indexPathForRow(at: textField.convert(CGPoint.zero, to: tableView)),
           let cell = tableView.cellForRow(at: indexPath) {

            switch indexPath.section {
            case 1:
                if let commentsCell = cell as? CommentsTableViewCell {
                    // Access the commentsTextField value and update your data model accordingly
                    if let comments = commentsCell.commentsTextField.text {
                        // Update your data model with the comments value
                        print("Comments: \(comments)")
                        self.comment = comments
                    }
                }
            case 2:
                if let detailsCell = cell as? DetailsTableViewCell {
                    // Access the dateTextField, areaTextField, and taskCategoryTextField values
                    if let date = detailsCell.dateTextField.text {
                        // Update your data model with the date value
                        print("Date: \(date)")
                        self.dateDetails = date
                    }
                    if let area = detailsCell.areaTextField.text {
                        // Update your data model with the area value
                        print("Area: \(area)")
                        self.area = area
                    }
                    if let taskCategory = detailsCell.categoryTextField.text {
                        // Update your data model with the task category value
                        print("Task Category: \(taskCategory)")
                        self.taskCategory = taskCategory
                    }
                    if let tags = detailsCell.tagsTextField.text {
                        // Update your data model with the task category value
                        print("Task Category: \(tags)")
                        self.tags = tags
                    }
                }
            case 3:
                if let eventsCell = cell as? LinkToExistingEventTableViewCell {
                    // Access the dateTextField, areaTextField, and taskCategoryTextField values
                    if let event = eventsCell.eventTextField.text {
                        // Update your data model with the date value
                        print("Event: \(event)")
                        self.event = event
                    }
                    
                }
                
            default:
                break
            }
        }
    }
}
