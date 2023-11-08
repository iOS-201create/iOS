//
//  ErrorModel.swift
//  iOS_201
//
//  Created by Hyeonho on 11/5/23.
//

import Foundation

struct ErrorModel: Codable, Error {
    let error : String?
    let status_code : Int?
}
