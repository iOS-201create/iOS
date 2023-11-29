//
//  CreateStudyModel.swift
//  iOS_201
//
//  Created by 유준용 on 11/21/23.
//

import Foundation


struct CreateStudyModel  {
    
    struct Request: Encodable {
        let name                    : String?
        let numberOfMaximumMembers  : Int?
        let minimumWeeks            : Int?
        let meetingDaysCountPerWeek : Int?
        let introduction            : String?
    }
    /// body = None
    struct Response: Decodable { }
}


