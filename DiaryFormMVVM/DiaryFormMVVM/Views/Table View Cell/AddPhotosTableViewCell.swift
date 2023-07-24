//
//  AddPhotosTableViewCell.swift
//  DiaryFormMVVM
//
//  Created by Danmark Arqueza on 7/24/23.
//

import UIKit
import PhotosUI

class AddPhotosTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {


    
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    // Data source to hold selected photos
    var selectedPhotos: [UIImage] = [] {
        didSet {
            // Update the collection view height based on the number of selected photos
            collectionViewHeightConstraint.constant = selectedPhotos.isEmpty ? 0 : 80
            collectionView.reloadData()
        }
    }
    
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


    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        // Create a UICollectionViewFlowLayout with horizontal scroll direction
               let flowLayout = UICollectionViewFlowLayout()
               flowLayout.scrollDirection = .horizontal

               // Assign the flow layout to the collection view
               collectionView.collectionViewLayout = flowLayout
        
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCell")
                
        addPhotoButton.addTarget(self, action: #selector(addPhotoButtonTapped), for: .touchUpInside)
        checkBoxButton.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func updateCheckboxImage() {
        let checkboxImage = isChecked ? checkedImage : uncheckedImage
        checkBoxButton.setImage(checkboxImage, for: .normal)
        checkBoxButton.tintColor = isChecked ? .colorWithRGBHex(0xFFA4D541) : .lightGray
    }
    
    // Add Photo button action
    @objc func addPhotoButtonTapped() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 10
        configuration.filter = PHPickerFilter.images
        let picker = PHPickerViewController(configuration: configuration)
        
        picker.delegate = self
        window?.rootViewController?.present(picker, animated: true, completion: nil)


    }
    
    @objc private func checkboxTapped() {
        isChecked = !isChecked
    }
    
    // Implement the PHPickerViewControllerDelegate method to handle photo selection
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)

        // Handle the selected photos here
        for result in results {
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                    if let pickedImage = image as? UIImage {
                        DispatchQueue.main.async {
                            self?.selectedPhotos.append(pickedImage)
                            self?.collectionView.reloadData()
                        }

                    }
                }
            }
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            selectedPhotos.append(pickedImage)
            collectionView.reloadData()
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UICollectionViewDataSource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        cell.backgroundColor = UIColor.lightGray
        
        // Create an image view for each selected photo
        let imageView = UIImageView(frame: cell.bounds)
        imageView.image = selectedPhotos[indexPath.item]
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        cell.addSubview(imageView)
        
        // Add a "Remove" button to the photo
        let removeButton = UIButton(type: .custom)
        removeButton.setImage(UIImage(named: "btn_remove_image"), for: .normal)
        removeButton.frame = CGRect(x: cell.bounds.width - 36, y: 0, width: 36, height: 36)
        removeButton.addTarget(self, action: #selector(removeButtonTapped(_:)), for: .touchUpInside)
        removeButton.tag = indexPath.item
        cell.addSubview(removeButton)
        
        return cell
    }
    
    // Optional: Implement UICollectionViewDelegateFlowLayout method to set the size of each cell
    // For horizontal scrolling, set the width of each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Set the width of the cell to make it scroll horizontally
        return CGSize(width: 80, height: collectionView.bounds.height)
    }
    
    // Remove button action
    @objc func removeButtonTapped(_ sender: UIButton) {
        let indexToRemove = sender.tag
        selectedPhotos.remove(at: indexToRemove)
        collectionView.reloadData()
    }
    


}
