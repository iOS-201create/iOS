//
//  AuthModel.swift
//  iOS_201
//
//  Created by Hyeonho on 11/5/23.
//

import Foundation

struct AuthModel: Codable, Hashable {
    let tokenType: String
    let accessToken: String
    let scope: String
    
    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case accessToken = "access_token"
        case scope = "scope"
    }
}
