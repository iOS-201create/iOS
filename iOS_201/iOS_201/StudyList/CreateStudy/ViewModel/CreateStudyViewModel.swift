//
//  CreateStudyViewModel.swift
//  iOS_201
//
//  Created by 유준용 on 11/21/23.
//

import Foundation
import Alamofire

final class CreateStudyViewModel {
    
    
    //MARK: - Properties
//    func toDictionary() -> [String: Any] {
//        guard let data = try? JSONEncoder().encode(self),
//              let jsonData = try? JSONSerialization.jsonObject(with: data),
//              let dictionaryData = jsonData as? [String: Any] else { return [:] }
//        return dictionaryData
//    }
    
    
    //TODO: - git 정보 받아오기 시작하면 필터에 따라 /study/waiting API콜 해야함.
    func postData(completion: @escaping () -> Void){
        
        let url = "https://test.201-study.shop/v1/studies"
        
        let headers: HTTPHeaders = [
            "accept": "*/*",
            "Authorization": AuthService.share.authModel?.accessToken ?? "",
            "Content-Type": "application/json"
        ]
        
        let requestModel = CreateStudyModel.Request(name: "iOS 스터디 모집", numberOfMaximumMembers: 3, minimumWeeks: 3, meetingDaysCountPerWeek: 3, introduction: "화이팅")
        
        AF.request(url,
                   method: .post,
                   parameters: requestModel.asParameters(),
                   encoding: JSONEncoding.default,
                   headers: headers
        )
        .responseDecodable(of: CreateStudyModel.Response.self,  completionHandler: { response in
            print(response.debugDescription)
            switch response.result {
            case .success(let data):
                print(#function, data)
            case .failure(let error):
                print(#function, error)
            }
        })
    }
}


