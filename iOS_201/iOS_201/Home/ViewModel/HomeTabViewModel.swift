//
//  HomeTabViewModel.swift
//  iOS_201
//
//  Created by Hyeonho on 12/3/23.
//

import Foundation

import Alamofire
import RxSwift

class HomeTabViewModel {
    var data : [MyStudyModel]?
    
    init() {
        // 테스트용 데이터
        self.data = MyStudyModel.MOCK_studyModel
    }
    
    func requestHomeFeed() -> Observable<[MyStudyModel]> {

        return Observable.of(
)
        let url = "https://test.201-study.shop/v1/members/my"
        
        let headers: HTTPHeaders = ["Accept": "application/json"]
        
        AF.request( url,
                    method: .get,
                    headers: headers,
                    interceptor: TokenRequestInterceptor()
        ).responseDecodable(of: [MyStudyModel].self) { [weak self] response in
            switch response.result {
            case .success(let home):
                self?.data = home
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
//        return Observable.of(data ?? [])
        
    }
    
    func requestHomeFeed2() -> Observable<[MyStudyModel]> {
        
        return Observable.of(self.data!)
        
    }
}

