//
//  StudyList.swift
//  iOS_201
//
//  Created by 유준용 on 2023/11/04.
//

import Foundation

struct StudyListModel {
    
    struct Request: Encodable{}
    
    struct Response: Decodable{
        let id                      : Int?
        let processingStatus        : Int?
        let name                    : String?
        let averageTier             : Int?
        let createdAt               : String?
        let numberOfCurrentMembers  : Int?
        let numberOfMaximumMembers  : Int?
        let meetingDaysPerWeek      : Int?
        let minimumWeeks            : Int?
    }
}
