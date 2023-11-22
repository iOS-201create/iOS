//
//  ProfileModel.swift
//  iOS_201
//
//  Created by Hyeonho sin on 11/22/23.
//

import Foundation

struct ProfileModel: Decodable {
    
    let id                  : Int
    let nickname             : String
    let githubId             : String
    let profileImageUrl       : String
    let successRate          : Int
    let successfulRoundCount  : Int
    let tierProgress         : Int
    let tier                : Int
    let introduction          : String
}

