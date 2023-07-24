//
//  NewDiaryFormTableViewController.swift
//  DiaryFormMVVM
//
//  Created by Danmark Arqueza on 7/24/23.
//

import UIKit

import UIKit

class NewDiaryFormTableViewController: UITableViewController {

    // Your array to store the selected photos
    var selectedPhotos: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.colorWithRGBHex(0xFFF2F5F7)
        tableView.separatorStyle = .none
        // Register custom cell classes for reuse
//        tableView.register(UINib(nibName: "AddPhotoCollectionViewCell", bundle: nil), forCellReuseIdentifier: "AddPhotoCell")
        tableView.register(UINib(nibName: "AddPhotosCell", bundle: nil), forCellReuseIdentifier: "AddPhotosCell")
        tableView.register(UINib(nibName: "CommentsCell", bundle: nil), forCellReuseIdentifier: "CommentsCell")
        tableView.register(UINib(nibName: "DetailsCell", bundle: nil), forCellReuseIdentifier: "DetailsCell")
        tableView.register(UINib(nibName: "LinkToEventCell", bundle: nil), forCellReuseIdentifier: "LinkToEventCell")
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
            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as! CommentsTableViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear.withAlphaComponent(0)
            // Configure the Comments cell here
            return cell

        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsTableViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear.withAlphaComponent(0)
            // Configure the Details cell here
            return cell

        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LinkToEventCell", for: indexPath) as! LinkToExistingEventTableViewCell
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear.withAlphaComponent(0)
            // Configure the Link to Event cell here
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
    

    
    // Implement the heightForFooterInSection method to specify the height of the footer view
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // Set the height of the footer view for the last section (where the "Next" button is located)
        if section == numberOfSections(in: tableView) - 1 {
            return 54 // Set the desired height for the footer view
        }

        return 0.01 // Set the height to a small value for other sections to hide the empty footer
    }

    @objc func nextButtonTapped() {
        // Handle the action when the "Next" button is tapped
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
