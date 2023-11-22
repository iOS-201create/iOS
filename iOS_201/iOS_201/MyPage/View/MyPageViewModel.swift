//
//  MyPageViewModel.swift
//  iOS_201
//
//  Created by Hyeonho sin on 11/22/23.
//

import Foundation

import Alamofire
import RxSwift

class MyPageViewModel {
    
    func requestMyProfile() {
        let url = "https://test.201-study.shop/v1/members/my"
        
        let headers: HTTPHeaders = ["Accept": "application/json"]

        AF.request(url,
                   method: .get,
                   headers: headers,
                   interceptor: TokenRequestInterceptor()
        ).responseDecodable(of: ProfileModel.self) { response in
            switch response.result {
            case .success(let result):
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
