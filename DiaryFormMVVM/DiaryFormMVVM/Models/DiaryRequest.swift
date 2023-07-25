//
//  DiaryRequest.swift
//  DiaryFormMVVM
//
//  Created by Danmark Arqueza on 7/26/23.
//

struct DiaryRequest: Encodable {
    let imagesBase64: [String]
    let comments: String
    let date: String
    let area: String
    let taskCategory: String
    let tags: String
    let linkToExistingEvent: String
}
