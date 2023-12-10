//
//  StudyMembers.swift
//  iOS_201
//
//  Created by Hyeonho on 12/10/23.
//

import Foundation

struct StudyMembers: Codable{
    let members: [Member]
    
    static var MOCK_StudyMembers = StudyMembers(members: [
        Member(id: 1, tier: 4, nickname: "test1", successRate: 60, profileImage: "star", isDeleted: false),
        Member(id: 2, tier: 4, nickname: "test2", successRate: 60, profileImage: "person", isDeleted: false),
        Member(id: 3, tier: 4, nickname: "asdsadsatest3asdasdzxczxc", successRate: 60, profileImage: "person", isDeleted: false),
        Member(id: 4, tier: 4, nickname: "test4", successRate: 60, profileImage: "person", isDeleted: false),
        Member(id: 5, tier: 4, nickname: "test5", successRate: 60, profileImage: "person", isDeleted: false)
    ])
}

struct Member: Codable {
    let id: Int
    let tier: Int
    let nickname: String
    let successRate: Int
    let profileImage: String
    let isDeleted: Bool
}

