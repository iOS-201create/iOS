//
//  UserService.swift
//  iOS_201
//
//  Created by Hyeonho on 11/5/23.
//

import Foundation

import Alamofire

class UserService {
    static let share = UserService()

    /// 닉네임 중복 검사
    func shouldEnalbeNickname(nickname: String, completion: @escaping (Result<NicknameModel,ErrorModel>) -> Void ) {
        let url = "https://test.201-study.shop/v1/members/exists?nickname=\(nickname)"
        
        let headers: HTTPHeaders = ["Accept": "application/json"]

        AF.request(url,
                   method: .get,
                   headers: headers
        ).responseDecodable(of: NicknameModel.self) { response in
            switch response.result {
            case .success(let data):
                
                guard let statusCode = response.response?.statusCode else {
                    completion(.failure(ErrorModel(error: "statusCode is nil", status_code: nil)))
                    return
                }
                
                switch statusCode {
                case 200:
                    completion(.success(data))
                default:
                    if let errorData = response.data,
                       let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: errorData) {
                        completion(.failure(errorModel))
                    }else {
                        completion(.failure(ErrorModel(error: "UnKnownError", status_code: nil)))
                    }
                }
                
            case .failure(let error):
                completion(.failure(ErrorModel(error: error.localizedDescription, status_code: nil)))
            }
        }
    }
    
    /// 온보딩 여부 검사
    
    /// 유저정보 수정
    func patchUserInfo(nickname: String, content: String, accessToken: String, completion: @escaping (Bool) -> Void ) {
        let url = "https://test.201-study.shop/v1/members"
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": accessToken,
            "Content-Type": "application/json",
        ]
        
        let params: [String: String] = [
            "nickname" : nickname,
            "introduction": content
        ]

        AF.request(url,
                   method: .patch,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: headers
        ).response { result in
            switch result.response?.statusCode {
            case 200:
                print("200 성공")
                completion(true)
            case 401:
                print("401")
                completion(false)
            case 500:
                print("500")
                completion(false)
            default:
                print("?")
                completion(false)
            }
        }

    }
}
