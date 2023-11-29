//
//  Encodable.swift
//  iOS_201
//
//  Created by 유준용 on 11/21/23.
//

import Foundation
import Alamofire

extension Encodable{
    
    func asParameters() -> Parameters {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(self)
        let parameters = try? JSONSerialization.jsonObject(with: data!, options: []) as? Parameters
        return parameters ?? [:]
    }
}
