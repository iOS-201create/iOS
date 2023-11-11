//
//  AuthModel.swift
//  iOS_201
//
//  Created by Hyeonho on 11/5/23.
//

import Foundation

struct AuthModel: Codable, Hashable {
    let accessToken: String
    let refreshToken: String
}
