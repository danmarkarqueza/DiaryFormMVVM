//
//  NewDiaryFormViewController.swift
//  DiaryFormMVVM
//
//  Created by Danmark Arqueza on 7/24/23.
//

import UIKit

class NewDiaryFormViewController: UIViewController {
    
    var newDiaryFormTableViewController: NewDiaryFormTableViewController?
    let containerView = UIView() // Define containerView here


    override func viewDidLoad() {
            super.viewDidLoad()
        
        // Create the custom title bar view
        let titleBarView = UIView()
        titleBarView.backgroundColor = UIColor.black // Customize the background color as needed
        titleBarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleBarView)


        // Set up constraints for the title bar view to cover the top of the screen
        let safeGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            titleBarView.topAnchor.constraint(equalTo: safeGuide.topAnchor),
            titleBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleBarView.heightAnchor.constraint(equalToConstant: 60) // Set the desired height of the title bar
        ])

        // Add the "New Diary" label to the title bar
        let titleLabel = UILabel()
        titleLabel.text = "New Diary"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold) // Customize the font and size as needed
        titleLabel.textColor = UIColor.white // Customize the text color as needed
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleBarView.addSubview(titleLabel)


        // Add the close button to the title bar
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = UIColor.white
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        titleBarView.addSubview(closeButton)


        // Set up constraints for the close button to align it to the left
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: titleBarView.leadingAnchor, constant: 16),
            closeButton.centerYAnchor.constraint(equalTo: titleBarView.centerYAnchor)
        ])


        // Set up constraints for the title label to align it to the right of the close button
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: 15),
            titleLabel.centerYAnchor.constraint(equalTo: titleBarView.centerYAnchor)
        ])
        
        
        // Create the LocationView
        let locationView = LocationView()
        locationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationView)
        
        // Add constraints for the LocationView below the TitleBarView
        NSLayoutConstraint.activate([
            locationView.topAnchor.constraint(equalTo: titleBarView.bottomAnchor),
            locationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationView.heightAnchor.constraint(equalToConstant: 50)
        ])
        

        // Set up containerView to occupy the whole screen
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: locationView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Create an instance of MyTableViewController
        newDiaryFormTableViewController = NewDiaryFormTableViewController()
        
                // Embed the table view controller in the container view
                addChild(newDiaryFormTableViewController!)
        newDiaryFormTableViewController?.view.frame = containerView.bounds
                containerView.addSubview(newDiaryFormTableViewController!.view)
        newDiaryFormTableViewController?.didMove(toParent: self)

                // Set the container view's autoresizing mask to adjust the table view's size when the parent view changes size (e.g., during rotation)
                containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        }
    
    private func setupTableView() {
       

    }
    
    @objc func closeButtonTapped() {
        // Handle the action when the close button is tapped
    }
    
}
