//
//  ImageUtils.swift
//  DiaryFormMVVM
//
//  Created by Danmark Arqueza on 7/26/23.
//

import UIKit

class ImageUtils {
    static func convertImageToBase64(image: UIImage, completion: @escaping (String?) -> Void) {
            if let compressedImageData = image.jpegData(compressionQuality: 0.5) {
                let base64String = compressedImageData.base64EncodedString()
                print("Base64 string:", base64String)
                completion(base64String)
            } else {
                print("Failed to convert image to data.")
                completion(nil)
            }
        }
}
