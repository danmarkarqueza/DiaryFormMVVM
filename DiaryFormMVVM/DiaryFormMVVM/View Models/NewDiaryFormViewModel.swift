//
//  NewDiaryFormViewModel.swift
//  DiaryFormMVVM
//
//  Created by Danmark Arqueza on 7/26/23.
//


import Foundation
import Alamofire

class NewDiaryFormViewModel {

    func createDiaryRequest(diaryRequest: DiaryRequest, completion: @escaping (Result<DiaryResponse, Error>) -> Void) {
        let apiUrl = Constants.baseUrl + Constants.createDiaryEndpoint

        guard let url = URL(string: apiUrl) else {
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        AF.request(url, method: .post, parameters: diaryRequest, encoder: JSONParameterEncoder.default).responseDecodable(of: DiaryResponse.self) { response in
                    switch response.result {
                    case .success(let diaryResponse):
                        completion(.success(diaryResponse))
                    case .failure(let error):
                        completion(.failure(error))
                    }
        }

    }
}

